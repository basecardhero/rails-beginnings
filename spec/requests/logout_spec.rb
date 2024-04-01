require 'rails_helper'

RSpec.describe "Logout", type: :request do
  describe "DELETE /logout" do
    let(:user) { create(:user, password: "password123") }

    describe "as a logged in user" do
      before(:each) { sign_in_as user }

      it "will reset the session and redirect to the home path" do
        delete logout_path
        expect(response).to redirect_to root_path
        expect(session[:user_id]).to be_nil
      end
    end

    describe "as an anonymous user" do
      it "will reset the session and redirect to the home path" do
        delete logout_path
        expect(response).to redirect_to root_path
        expect(session[:user_id]).to be_nil
      end
    end
  end
end
