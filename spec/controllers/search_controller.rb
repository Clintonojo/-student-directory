require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe "GET #index with search" do
    before do
      @john = Student.create!(name: "John Smith", email: "john@school.com", phone: "0891111111", course: "CS", year: "2024")
      @sarah = Student.create!(name: "Sarah Johnson", email: "sarah@school.com", phone: "0892222222", course: "Biology", year: "2023")
    end

    it "returns all students without search parameters" do
      get :index
      expect(assigns(:students)).to include(@john)
      expect(assigns(:students)).to include(@sarah)
    end

    it "returns matching students when searching by name" do
      get :index, params: { q: { name_cont: "John" } }
      expect(assigns(:students)).to include(@john)
      expect(assigns(:students)).not_to include(@sarah)
    end

    it "returns matching students when searching by course" do
      get :index, params: { q: { course_eq: "CS" } }
      expect(assigns(:students)).to include(@john)
      expect(assigns(:students)).not_to include(@sarah)
    end
  end
end
