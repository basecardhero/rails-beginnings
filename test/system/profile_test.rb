require "application_system_test_case"

class ProfileTest < ApplicationSystemTestCase
  test "a user can update their profile" do
    user = users(:one)
    sign_in_as(user)

    visit profile_url
    fill_in "Email", with: "john.doe.2@example.com"
    fill_in "Username", with: "JohnDoe2"
    click_on "Update Profile"

    assert_current_path profile_url
    assert_text "Profile updated"
  end

  test "a user sees an error message when they try to update their profile with invalid data" do
    user = users(:one)
    existing_user = users(:confirmed)
    sign_in_as(user)

    visit profile_url
    fill_in "Email", with: existing_user.email_address
    fill_in "Username", with: "!!not_valid_username!!"
    click_on "Update Profile"

    assert_current_path profile_url
    assert_text "Email address has already been taken"
    assert_text "Username must contain only letters and numbers"
  end
end
