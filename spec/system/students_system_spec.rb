require 'rails_helper'

RSpec.describe "Student management", type: :system do
  # Use rack_test driver since we don't need JavaScript
  before do
    driven_by(:rack_test)
  end

  # Simple test for student creation
  it "creates a new student" do
    # Visit the new student form
    visit new_student_path

    # Fill out the form
    fill_in "Name", with: "System Test Student"
    fill_in "Email", with: "system@student.com"
    fill_in "Phone", with: "0892222222"
    fill_in "Course", with: "Data Science"
    fill_in "Year", with: "2024"

    # Submit the form
    click_button "Create Student"

    # Just check the student was created
    expect(page).to have_content("System Test Student")
    expect(page).to have_content("system@student.com")
  end

  # Simple edit test
  it "edits an existing student" do
    # Create test student
    student = Student.create!(
      name: "Original Name",
      email: "original@example.com",
      phone: "0891111111",
      course: "Original Course",
      year: "2023"
    )

    # Visit edit page
    visit edit_student_path(student)

    # Update student details
    fill_in "Name", with: "Updated Name"

    # Submit form
    click_button "Update Student"

    # Verify update worked
    expect(page).to have_content("Updated Name")
  end

  # Simple show test
  it "shows a student" do
    student = Student.create!(
      name: "Show Student",
      email: "show@example.com",
      phone: "0892222222",
      course: "Test Course",
      year: "2024"
    )

    visit student_path(student)

    expect(page).to have_content("Show Student")
    expect(page).to have_content("Test Course")
  end

  # Simple delete test
  it "deletes a student" do
    student = Student.create!(
      name: "Delete Student",
      email: "delete@example.com",
      phone: "0893333333",
      course: "Delete Course",
      year: "2022"
    )

    visit students_path

    # Find delete button within the table row containing our student's name
    within("tr", text: "Delete Student") do
      click_button "Delete"
    end

    # After deletion
    expect(page).not_to have_content("Delete Student")
  end
end
