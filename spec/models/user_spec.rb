require "rails_helper"

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create!(email: "user1@example.org", username: "user123",
      password: "password123", password_confirmation: "password123",
      confirmed_at: DateTime.now)
  end

  describe "#email" do
    before(:each) do
      @user2 = User.new(email: nil, username: "user123",
        password: "password123", password_confirmation: "password123",
        confirmed_at: DateTime.now)
    end

    it "is required" do
      expect(@user2.valid?).to be(false)
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

  describe "#username" do
    before(:each) do
      @user2 = User.new(email: "user2@example.org", username: nil,
      password: "password123", password_confirmation: "password123",
      confirmed_at: DateTime.now)
    end

    it "is required" do
      @user2.valid?
      expect(@user2.errors[:username]).to eq(["can't be blank"])
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
  end
end
