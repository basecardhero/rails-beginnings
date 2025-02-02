require "application_system_test_case"

class PasswordResetTest < ApplicationSystemTestCase
  test "a user can submit their email to reset their password" do
    visit new_password_url

    fill_in "Email", with: users(:confirmed).email_address
    click_on "Email reset instructions"

    assert_current_path new_session_url
    assert_text "Password reset instructions sent (if user with that email address exists)."
  end

  test "a user can reset their password when they have a valid token" do
    user = users(:confirmed)

    visit edit_password_url(user.generate_token_for(:password_reset))
    fill_in "New Password", with: "new_password"
    fill_in "Confirm New Password", with: "new_password"
    click_on "Save New Password"

    assert_current_path new_session_url
    assert_text "Your password has been reset. You may now log in."
  end

  test "a user cannot reset their password when they have an invalid token" do
    visit edit_password_url("not_a_valid_token")

    assert_current_path new_password_url
    assert_text "Password reset link is invalid or has expired."
  end

  test "a user cannot reset their password when the password and password confirmation does not match" do
    token = users(:confirmed).generate_token_for(:password_reset)

    visit edit_password_url(token)
    fill_in "New Password", with: "new_password"
    fill_in "Confirm New Password", with: "NOT_new_password"
    click_on "Save New Password"

    assert_current_path edit_password_url(token)
    assert_text "Password confirmation doesn't match Password"
  end
end
