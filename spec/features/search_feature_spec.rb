require 'rails_helper'

RSpec.describe "Search feature", type: :feature do
  before do
    Student.destroy_all  # Clean the database
    @john = Student.create!(name: "John Smith", email: "john@school.com", phone: "0891111111", course: "CS", year: "2024")
    @sarah = Student.create!(name: "Sarah Johnson", email: "sarah@school.com", phone: "0892222222", course: "IT", year: "2023")
  end

  it "filters students by name" do
    visit students_path

    # Confirm we see both students before searching
    expect(page).to have_content("John Smith")
    expect(page).to have_content("Sarah Johnson")

    # Search for John
    fill_in "Name contains", with: "John"
    click_button "Search"

    # After search, we should only see John
    expect(page).to have_content("John Smith")
    expect(page).not_to have_css("tbody tr", text: "Sarah Johnson")
  end
end
