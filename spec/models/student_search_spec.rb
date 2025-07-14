require 'rails_helper'

RSpec.describe Student, type: :model do
  describe "ransack search" do
    before do
      Student.destroy_all  # Clean the database
      @john = Student.create!(name: "John Smith", email: "john@school.com", phone: "0891111111", course: "CS", year: "2024")
      @sarah = Student.create!(name: "Sarah Johnson", email: "sarah@school.com", phone: "0892222222", course: "IT", year: "2023")
    end

    it "filters by name_cont" do
      # Use custom search method instead of direct Ransack call
      result = Student.search({ q: { name_cont: "John" } })

      # Debug output
      puts "Result count: #{result.count}"
      puts "Result names: #{result.map(&:name).join(', ')}"

      expect(result).to include(@john)
      expect(result).not_to include(@sarah)
    end

    it "filters by name_case_sensitive_cont" do
      # Use custom search method instead of direct Ransack call
      result = Student.search({ q: { name_case_sensitive_cont: "John" } })

      # Debug output
      puts "Case-sensitive result count: #{result.count}"
      puts "Case-sensitive result names: #{result.map(&:name).join(', ')}"

      expect(result).to include(@john)
      expect(result).not_to include(@sarah)
    end

    it "uses ransack's result method for non-name searches" do
      # This will execute the q.result(distinct: true) line
      # by searching on a field other than name
      result = Student.search({ q: { course_eq: "CS" } })

      # Debug output
      puts "Course search result count: #{result.count}"
      puts "Course search names: #{result.map(&:name).join(', ')}"

      expect(result).to include(@john)
      expect(result).not_to include(@sarah)
    end
  end
end
