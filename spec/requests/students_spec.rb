require 'rails_helper'

RSpec.describe "Students", type: :request do
  # Testing student creation via POST request
  # These are integration tests that test the full HTTP request cycle
  describe "POST /students" do
    it "creates a new student and redirects" do
      # Check that the database count increases after the POST
      expect {
        post students_path, params: {
          student: {
            name: "Test Student",
            email: "test@example.com",
            phone: "0891234567",
            course: "CS",
            year: "2025"
          }
        }
      }.to change(Student, :count).by(1)

      # Test the redirect happens correctly
      expect(response).to redirect_to(Student.last)

      # Follow the redirect to check the resulting page
      follow_redirect!

      # Make sure the page contains our student's info
      expect(response.body).to include("Test Student")
    end
  end

  # Testing the index page - shows list of students
  describe "GET /students" do
    it "returns a list of students" do
      # Create a test student so we have something to see
      student = Student.create!(
        name: "Index Test",
        email: "index@example.com",
        phone: "0891111111",
        course: "CS",
        year: "2024"
      )

      # Request the index
      get students_path

      # Should be successful
      expect(response).to have_http_status(200)

      # Should contain student info
      expect(response.body).to include("Index Test")
    end
  end

  # Test show page - displays single student
  describe "GET /students/:id" do
    it "shows a specific student's details" do
      student = Student.create!(
        name: "Show Test",
        email: "show@example.com",
        phone: "0892222222",
        course: "History",
        year: "2023"
      )

      get student_path(student)

      expect(response).to have_http_status(200)
      expect(response.body).to include("Show Test")
      expect(response.body).to include("History")
    end
  end

  # Test deletion - removes students from database
  describe "DELETE /students/:id" do
    it "deletes a student" do
      # Create a student, then delete them
      student = Student.create!(
        name: "Delete Me",
        email: "delete@example.com",
        phone: "0893333333",
        course: "Math",
        year: "2022"
      )

      # Check the database count decreases
      expect {
        delete student_path(student)
      }.to change(Student, :count).by(-1)

      # Should redirect to index
      expect(response).to redirect_to(students_path)
    end
  end
end
