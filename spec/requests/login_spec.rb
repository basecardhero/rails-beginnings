require "rails_helper"

RSpec.describe "Login", type: :request do
  describe "GET /login" do
    it "will return a 200 response status" do
      get login_path
      expect(response).to have_http_status 200
      expect(response.body).to include 'name="login_form[email]"'
      expect(response.body).to include 'name="login_form[password]"'
      expect(response.body).to include 'value="Log in"'
    end
  end

  describe "POST /login" do
    let(:user) { create :user, password: "password123" }

    it "will log in the user" do
      post login_path, params: { login_form: { email: user.email, password: user.password } }
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to be user.id
      expect(flash[:alert]).to be_nil
    end

    it "will not login the user with invalid password" do
      post login_path, params: { login_form: { email: user.email, password: "not_the_password" } }
      expect(response).to have_http_status :unprocessable_entity
      expect(flash[:alert]).to eq "Invalid email or password"
      expect(response.body).to include "Invalid email or password"
      expect(session[:user_id]).to be_nil
    end

    it "will not login the user with invalid email" do
      post login_path, params: { login_form: { email: "not.john.doe@example.com", password: user.password } }
      expect(response).to have_http_status :unprocessable_entity
      expect(flash[:alert]).to eq "Invalid email or password"
      expect(response.body).to include "Invalid email or password"
      expect(session[:user_id]).to be_nil
    end
  end
end
