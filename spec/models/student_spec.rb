require 'rails_helper'

RSpec.describe Student, type: :model do
  # This test checks that a student with all required fields is valid
  # It's like the "happy path" test - everything should work when done right
  it "is valid with valid attributes" do
    student = Student.new(name: "Jane", email: "jane@example.com", phone: "123456", course: "IT", year: "Year 2")
    expect(student).to be_valid # Should pass all validations
  end

  # This test makes sure we can't create students without names
  # Important because we need to identify students somehow!
  it "is invalid without a name" do
    student = Student.new(name: nil, email: "jane@example.com", phone: "123456", course: "IT", year: "Year 2")
    expect(student).not_to be_valid # Should fail validation
    expect(student.errors[:name]).to include("can't be blank") # Should get specific error
  end

  # Email validation test - we need valid emails to contact students
  it "is invalid without an email" do
    student = Student.new(name: "Jane", email: nil, phone: "123456", course: "IT", year: "Year 2")
    expect(student).not_to be_valid
    expect(student.errors[:email]).to include("can't be blank")
  end

  # Course validation - need to know what program the student is in
  it "is invalid without a course" do
    student = Student.new(name: "Jane", email: "jane@example.com", phone: "123456", course: nil, year: "Year 2")
    expect(student).not_to be_valid
    expect(student.errors[:course]).to include("can't be blank")
  end

  # Year validation - need to know what year the student is in
  it "is invalid without a year" do
    student = Student.new(name: "Jane", email: "jane@example.com", phone: "123456", course: "IT", year: nil)
    expect(student).not_to be_valid
    expect(student.errors[:year]).to include("can't be blank")
  end
end
