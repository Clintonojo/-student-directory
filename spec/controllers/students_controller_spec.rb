require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:valid_attributes) {
    { name: "Test Student", email: "test@example.com", phone: "0891234567", course: "CS", year: "2024" }
  }

  let(:invalid_attributes) {
    { name: "", email: "", phone: "", course: "", year: "" }
  }

  describe "PUT #update" do
    context "with invalid params" do
      it "renders the edit template for HTML format" do
        student = Student.create! valid_attributes
        put :update, params: { id: student.to_param, student: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end

      it "returns JSON with errors for JSON format" do
        student = Student.create! valid_attributes
        put :update, params: { id: student.to_param, student: invalid_attributes, format: :json }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include("application/json")
      end
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "renders the new template for HTML format" do
        post :create, params: { student: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end

      it "returns JSON with errors for JSON format" do
        post :create, params: { student: invalid_attributes, format: :json }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to include("application/json")
      end
    end
  end
end
