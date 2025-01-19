require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  test "get new" do
    get new_password_url

    assert_response :success
  end

  test "an email can be submitted for password reset" do
    user = users(:one)

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
    user = users(:one)

    get edit_password_url(user.password_reset_token)

    assert_response :success
  end

  test "a password can be updated" do
    user = users(:one)

    patch password_url(user.password_reset_token), params: { user: { password: "newpassword", password_confirmation: "newpassword" } }

    assert_redirected_to new_session_url
    assert_equal "Your password has been reset. You may now log in.", flash[:notice]
    assert user.reload.authenticate("newpassword")
  end

  test "a password cannot be updated with invalid token" do
    user = users(:one)

    patch password_url("invalidtoken"), params: { user: { password: "newpassword", password_confirmation: "newpassword" } }

    assert_redirected_to new_password_url
    assert_equal "Password reset link is invalid or has expired.", flash[:alert]
    assert_not user.reload.authenticate("newpassword")
  end

  test "the password field will display error message if invalid" do
    user = users(:one)

    patch password_url(user.password_reset_token), params: { user: { password: "123123", password_confirmation: "newpassword" } }

    assert_response :unprocessable_entity
    assert response.body.include?("Password is too short (minimum is 10 characters)")
  end

  test "password confirmation will display error message if invalid" do
    user = users(:one)

    patch password_url(user.password_reset_token), params: { user: { password: "newpassword", password_confirmation: "newpassword2" } }

    assert_response :unprocessable_entity
    assert response.parsed_body.to_html.include?("Password confirmation doesn't match Password")
  end
end
