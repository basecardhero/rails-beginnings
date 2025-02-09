require "application_system_test_case"

class ProfileTest < ApplicationSystemTestCase
  test "a user can update their profile" do
    sign_in_as(:confirmed)
    visit profile_url
    fill_in "Username", with: "JohnDoe2"
    click_on "Update Profile"

    assert_current_path profile_url
    assert_text "Profile updated"
  end

  test "a user sees an error message when they try to update their profile with invalid data" do
    sign_in_as(:confirmed)
    visit profile_url
    fill_in "Username", with: "!!not_valid_username!!"
    click_on "Update Profile"

    assert_current_path profile_url
    assert_text "Username must contain only letters and numbers"
  end

  test "a confirmed user will see email confirmation date on their profile" do
    user = users(:confirmed)

    sign_in_as(user)
    visit profile_url

    assert_current_path profile_url
    assert_text "Confirmed at #{user.confirmed_at.strftime('%m/%d/%Y')}"
  end

  test "a user can update their email address" do
    sign_in_as(:confirmed)
    visit profile_url
    fill_in "Email", with: "new.email@example.com"
    click_on "Change Email"

    assert_current_path profile_url
    assert_text "Email address updated"
  end

  test "a user sees an error message when they try to update their email address with invalid data" do
    sign_in_as(:confirmed)
    visit profile_url
    fill_in "Email", with: "bad!email!example.com"
    click_on "Change Email"

    assert_current_path profile_url
    assert_text "Email address is invalid"
  end
end
