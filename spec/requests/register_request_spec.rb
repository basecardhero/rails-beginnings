require "rails_helper"

RSpec.describe "Register", type: :request do
  describe "GET /register" do
    it "will return a 200 response status" do
      get register_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /register" do
    it "will register create a new user" do
      post register_path, params: { user: { email: "john.doe@example.com", username: "johndoe123", password: "password123", password_confirmation: "password123" } }
      expect(response).to redirect_to root_path
      expect(flash[:success]).to eq "Thank you for registering. You may now log in."
      expect(User.find_by(email: "john.doe@example.com")).to be_a(User)
    end

    it "will render the form if errors" do
      post register_path, params: { user: { email: "", username: "", password: "password123", password_confirmation: "not_password123" } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to include(CGI.escapeHTML("Email can't be blank"))
      expect(response.body).to include(CGI.escapeHTML("Username can't be blank"))
      expect(response.body).to include(CGI.escapeHTML("Password confirmation doesn't match Password"))
      expect(User.find_by(email: "john.doe@example.com")).to be(nil)
    end
  end
end
