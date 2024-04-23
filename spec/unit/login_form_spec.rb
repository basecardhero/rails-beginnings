require "rails_helper"

RSpec.describe LoginForm do
  let(:login_form) { LoginForm.new email: "john.doe@example.com", password: "password123" }

  describe "formatting" do
    it "will strip and downcase email" do
      login_form.email = " \r \n JOHN.Doe@EXAMPLE.com \r \n "
      login_form.valid?
      expect(login_form.email).to eq "john.doe@example.com"
    end
  end

  describe "validation" do
    it "will be valid with the happy path" do
      expect(login_form.valid?).to be true
    end

    describe ".email" do
      it "will validate presence of email" do
        login_form.email = nil
        expect(login_form.valid?).to be false
        expect(login_form.errors.where(:email).first.full_message).to eq "Email can't be blank"
      end

      it "will validate presence of email" do
        login_form.email = ""
        expect(login_form.valid?).to be false
        expect(login_form.errors.where(:email).first.full_message).to eq "Email can't be blank"
      end

      it "will validate email format" do
        login_form.email = "not_an_email"
        expect(login_form.valid?).to be false
        expect(login_form.errors.where(:email).first.full_message).to eq "Email is invalid"
      end
    end

    describe ".password" do
      it "will validate password presence" do
        login_form.password = nil
        expect(login_form.valid?).to be false
        expect(login_form.errors.where(:password).first.full_message).to eq "Password can't be blank"
      end
    end
  end
end
