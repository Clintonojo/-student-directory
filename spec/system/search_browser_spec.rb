require 'rails_helper'

RSpec.describe "Search in browser", type: :system do
  before do
    Student.destroy_all  # Clean the database
    @john = Student.create!(name: "John Smith", email: "john@school.com", phone: "0891111111", course: "CS", year: "2024")
    @sarah = Student.create!(name: "Sarah Johnson", email: "sarah@school.com", phone: "0892222222", course: "IT", year: "2023")
  end

  it "filters students using JavaScript" do
    visit students_path

    # Confirm we see both students before searching
    expect(page).to have_content("John Smith")
    expect(page).to have_content("Sarah Johnson")

    fill_in "Name contains", with: "John"
    click_button "Search"

    # Wait for page to update
    sleep 1

    expect(page).to have_content("John Smith")
    expect(page).not_to have_content("Sarah Johnson")
  end
end
