require "rails_helper"

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create!(email: "user1@example.org", username: "user123",
      password: "password123", password_confirmation: "password123",
      confirmed_at: DateTime.now)

    @user2 = User.new(email: "user2@example.org", username: "user456",
      password: "password123", password_confirmation: "password123",
      confirmed_at: DateTime.now)
  end

  describe ".email" do
    it "is required" do
      @user2.email = nil
      @user2.valid?
      expect(@user2.errors[:email]).to eq(["can't be blank"])
    end

    it "is unqiue" do
      @user2.email = @user.email
      @user2.valid?
      expect(@user2.errors[:email]).to eq(["has already been taken"])
    end

    it "is case-insensitive" do
      @user2.email = @user.email.upcase
      @user2.valid?
      expect(@user2.errors[:email]).to eq(["has already been taken"])
    end
  end

  describe ".username" do
    it "is required" do
      @user2.username = nil
      @user2.valid?
      expect(@user2.errors[:username].first).to eq("can't be blank")
    end

    it "must be at least 6 characters" do
      @user2.username = "aaaaa"
      @user2.valid?
      expect(@user2.errors[:username]).to eq(["is too short (minimum is 6 characters)"])
    end

    it "cannot exceed 16 characters" do
      @user2.username = "aaaaaaaaaaaaaaaaa"
      @user2.valid?
      expect(@user2.errors[:username]).to eq(["is too long (maximum is 16 characters)"])
    end

    it "is unique" do
      @user2.username = @user.username
      @user2.valid?
      expect(@user2.errors[:username]).to eq(["has already been taken"])
    end

    it "is case-insensitive" do
      @user2.username = @user.username.upcase
      @user2.valid?
      expect(@user2.errors[:username]).to eq(["has already been taken"])
    end

    it "must be alphanumeric" do
      @user2.username = "#use r123!"
      @user2.valid?

      expect(@user2.errors[:username]).to eq(["may only contain of letters and numbers"])
    end
  end
end
