json.extract! student, :id, :name, :email, :phone, :course, :year, :created_at, :updated_at
json.url student_url(student, format: :json)
