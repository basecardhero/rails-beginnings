require "application_system_test_case"

class LogInTest < ApplicationSystemTestCase
  test "a user can log in" do
    user = users(:unconfirmed)

    visit new_session_url
    fill_in "Email", with: user.email_address
    fill_in "Password", with: "password123"
    click_on "Log in"

    assert_current_path root_url
    assert_text "Profile"
    assert_text "Logout"
  end

  test "when a invalid email or password are submitted, they will see an error message" do
    visit new_session_url
    fill_in "Email", with: "does.not.exist@example.com"
    fill_in "Password", with: "password123"
    click_on "Log in"

    assert_current_path new_session_url
    assert_text "Invalid email or password"
  end

  test "clicking on 'Forgot your password?' will take you to the forgot password page" do
    visit new_session_url
    click_on "Forgot your password?"

    assert_current_path new_password_url
  end
end
