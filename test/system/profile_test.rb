require "application_system_test_case"

class ProfileTest < ApplicationSystemTestCase
  test "a user can update their profile" do
    sign_in_as(:confirmed)
    visit profile_url
    fill_in "Email", with: "john.doe.2@example.com"
    fill_in "Username", with: "JohnDoe2"
    click_on "Update Profile"

    assert_current_path profile_url
    assert_text "Profile updated"
  end

  test "a user sees an error message when they try to update their profile with invalid data" do
    existing_user = users(:confirmed)

    sign_in_as(:one)
    visit profile_url
    fill_in "Email", with: existing_user.email_address
    fill_in "Username", with: "!!not_valid_username!!"
    click_on "Update Profile"

    assert_current_path profile_url
    assert_text "Email address has already been taken"
    assert_text "Username must contain only letters and numbers"
  end

  test "an unconfirmed user cannot update their profile" do
    user = users(:unconfirmed)
    params = { email_address: "different.email@example.com", username: "DifferentUsername" }

    sign_in_as(user)
    visit profile_url
    fill_in "Email", with: params[:email_address]
    fill_in "Username", with: params[:username]
    click_on "Update Profile"
    user.reload

    assert_current_path profile_url
    assert_text "Email address not confirmed. Please check your email for a confirmation link."
    assert_not_equal params[:username], user.username
    assert_not_equal params[:email_address], user.email_address
  end

  test "an unconfirmed user will see 'Pending confirmation' on their profile" do
    sign_in_as(:unconfirmed)
    visit profile_url

    assert_current_path profile_url
    assert_text "Pending confirmation"
  end

  test "a confirmed user will see email confirmation date on their profile" do
    user = users(:confirmed)

    sign_in_as(user)
    visit profile_url

    assert_current_path profile_url
    assert_text "Confirmed at #{user.confirmed_at.strftime('%m/%d/%Y')}"
  end
end
