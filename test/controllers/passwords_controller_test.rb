require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  test "get new" do
    get new_password_url

    assert_response :success
  end

  test "an email can be submitted for password reset" do
    user = users(:confirmed)

    assert_emails 1 do
      post passwords_url, params: { email_address: user.email_address }
    end
    assert_redirected_to new_session_url
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
  end

  test "when a non-existent email is submitted, no email is sent and the flash message shows" do
    assert_emails 0 do
      post passwords_url, params: { email_address: "user.does.not.exist@example.com" }
    end
    assert_redirected_to new_session_url
    assert_equal "Password reset instructions sent (if user with that email address exists).", flash[:notice]
  end

  test "get edit" do
    user = users(:confirmed)

    get edit_password_url(user.password_reset_token)

    assert_response :success
  end

  test "a password can be updated" do
    user = users(:confirmed)
    old_confirmed_at = user.confirmed_at

    patch password_url(user.password_reset_token), params: { user: { password: "newpassword", password_confirmation: "newpassword" } }

    assert_redirected_to new_session_url
    assert_equal "Your password has been reset. You may now log in.", flash[:notice]
    assert user.reload.authenticate("newpassword")
    assert_not_equal old_confirmed_at, user.reload.confirmed_at
  end

  test "the users sessions are destroyed when the password is updated" do
    user = users(:confirmed)
    user.sessions.create

    patch password_url(user.password_reset_token), params: { user: { password: "newpassword", password_confirmation: "newpassword" } }

    assert_empty user.reload.sessions
  end

  test "a password cannot be updated with invalid token" do
    user = users(:confirmed)

    patch password_url("invalidtoken"), params: { user: { password: "newpassword", password_confirmation: "newpassword" } }

    assert_redirected_to new_password_url
    assert_equal "Password reset link is invalid or has expired.", flash[:alert]
    assert_not user.reload.authenticate("newpassword")
  end

  test "the password field will display error message if invalid" do
    user = users(:confirmed)

    patch password_url(user.password_reset_token), params: { user: { password: "123123", password_confirmation: "newpassword" } }

    assert_response :unprocessable_entity
    assert response.body.include?("Password is too short (minimum is 10 characters)")
  end

  test "password confirmation will display error message if invalid" do
    user = users(:confirmed)

    patch password_url(user.password_reset_token), params: { user: { password: "newpassword", password_confirmation: "newpassword2" } }

    assert_response :unprocessable_entity
    assert response.parsed_body.to_html.include?("Password confirmation doesn't match Password")
  end
end
