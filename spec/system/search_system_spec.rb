require 'rails_helper'

RSpec.describe "Search functionality", type: :system do
  before do
    driven_by(:rack_test)

    # Create test data
    @john = Student.create!(name: "John Smith", email: "john@school.com", phone: "0891111111", course: "CS", year: "2024")
    @sarah = Student.create!(name: "Sarah Johnson", email: "sarah@school.com", phone: "0892222222", course: "IT", year: "2023")
  end

  it "shows the search form" do
    visit students_path
    expect(page).to have_content("Search Students")
    expect(page).to have_field("Name contains")
  end
end
