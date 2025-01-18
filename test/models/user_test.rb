require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = User.new(email_address: "john.doe@example.com", password: "password123")
    assert user.valid?
  end

  test "valid user with password_confirmation" do
    user = User.new(email_address: "john.doe@example.com", password: "password123", password_confirmation: "password123")
    assert user.valid?
  end

  test "email address normalization" do
    user = User.new(email_address: "  John.Doe@EXAMPLE.COM  \n ", password: "password123")
    assert_equal(user.email_address, "john.doe@example.com")
  end

  test "email address must be valid" do
    user = User.new(email_address: "not.an.email", password: "password123")
    assert_not user.valid?
    assert_equal user.errors[:email_address], [ "is invalid" ]
  end

  test "email must be unique" do
    User.create(email_address: "John.Doe@EXAMPLE.com", password: "password123")
    other_user = User.new(email_address: "john.doe@example.com", password: "password123")
    assert_not other_user.valid?
    assert_equal other_user.errors[:email_address], [ "has already been taken" ]
  end

  test "password is required" do
    user = User.new(email_address: "john.doe@example.com", password: "")
    assert_not user.valid?
    assert_equal user.errors[:password], [ "can't be blank", "is too short (minimum is 10 characters)" ]
  end

  test "password musts be at least 10 characters" do
    user = User.new(email_address: "john.doe@example.com", password: "aaaaaaaaa")
    assert_not user.valid?
    assert_equal user.errors[:password], [ "is too short (minimum is 10 characters)" ]
  end

  test "password must match password_confirmation" do
    user = User.new(email_address: "john.doe@example.com", password: "password123", password_confirmation: "password456")
    assert_not user.valid?
    assert_equal user.errors[:password_confirmation], [ "doesn't match Password" ]
  end

  test "generates_token_for email_confirmation will return the user for a valid token" do
    user = users(:one)
    token = user.generate_token_for(:email_confirmation)

    assert_equal user.id, User.find_by_token_for(:email_confirmation, token).id
  end

  test "generates_token_for email_confirmation will not work if confirmed_at has changed" do
    user = users(:one)
    token = user.generate_token_for(:email_confirmation)
    user.update(confirmed_at: Time.current)

    assert_nil User.find_by_token_for(:email_confirmation, token)
  end

  test "generates_token_for email_confirmation will not work if token is expired" do
    user = users(:one)
    token = user.generate_token_for(:email_confirmation)

    travel_to Time.current + 2.days do
      assert_nil User.find_by_token_for(:email_confirmation, token)
    end
  end
end
