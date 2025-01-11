require "test_helper"

class NewSessionFormTest < ActiveSupport::TestCase
  test "valid form" do
    form = NewSessionForm.new(email_address: "john.doe@example.com", password: "password123")
    assert form.valid?
    assert_equal form.email_address, "john.doe@example.com"
    assert_equal form.password, "password123"
  end

  test "email address must be present" do
    form = NewSessionForm.new(password: "password123")
    assert_not form.valid?
    assert_equal form.errors[:email_address], [ "is invalid" ]
  end

  test "email address must be valid" do
    form = NewSessionForm.new(email_address: "not.an.email", password: "password123")
    assert_not form.valid?
    assert_equal form.errors[:email_address], [ "is invalid" ]
  end

  test "password is required" do
    form = NewSessionForm.new(email_address: "john.doe@example.com")
    assert_not form.valid?
    assert_equal form.errors[:password], [ "can't be blank" ]
  end

  test "email address normalization" do
    form = NewSessionForm.new(email_address: " \n  JOHN.doe@EXAMPLE.com \n \t ", password: "password123")
    assert_equal form.email_address, "john.doe@example.com"
  end
end
