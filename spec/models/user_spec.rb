require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { should have_secure_password }

    describe ".username" do
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username).case_insensitive }
      it { should validate_length_of(:username).is_at_least(6) }
      it { should validate_length_of(:username).is_at_most(16) }
      it { should normalize(:username).from(" \r\n johndoe123 \n ").to("johndoe123") }
    end

    describe ".email" do
      it { should validate_presence_of(:email) }
      it { should normalize(:email).from(" JoHN.Doe@EXAMPLE.com \n ").to("john.doe@example.com") }
      it "will validate email format" do
        user = build(:user, email: "not_an_email")
        expect(user).to_not be_valid
        expect(user.errors.first.full_message).to eq("Email is invalid")
      end
    end

    describe ".password" do
      it { should validate_presence_of(:password) }
      it { should validate_confirmation_of(:password) }
    end
  end
end
