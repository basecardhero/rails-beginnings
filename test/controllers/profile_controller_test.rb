require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "#index exists" do
    sign_in_as(:confirmed)

    get profile_url

    assert_response :success
  end

  test "#update updates the user" do
    user = users(:confirmed)
    params = { user: { username: "newusername", email_address: "new.email@example.com" } }

    sign_in_as(user)
    patch profile_url, params: params
    user.reload

    assert_redirected_to profile_url
    assert_equal "Profile updated", flash[:notice]
    assert_equal params[:user][:username], user.username
    assert_equal params[:user][:email_address], user.email_address
  end

  test "#update with render :index when user is invalid" do
    params = { user: { email_address: "new.email@example.com" } }

    sign_in_as(:confirmed)
    patch profile_url, params: params

    assert_response :unprocessable_entity
  end

  test "#update requires email confirmation" do
    user = users(:unconfirmed)
    params = { user: { email_address: "different.email@example.com", username: "DifferentUsername" } }

    sign_in_as(user)
    patch profile_url, params: params
    user.reload()

    assert_redirected_to profile_url
    assert_equal "Email address not confirmed. Please check your email for a confirmation link.", flash[:alert]
    assert_not_equal params[:user][:username], user.username
    assert_not_equal params[:user][:email_address], user.email_address
  end

  test "#update_password updates the user's password" do
    user = users(:confirmed)
    params = { user: { password: "newpassword", password_confirmation: "newpassword", current_password: "password123" } }

    sign_in_as(user)
    assert_enqueued_emails 1 do
      patch profile_password_url, params: params
    end

    assert_redirected_to profile_url
    assert_equal "Password updated", flash[:notice]
    assert user.reload.authenticate("newpassword")
  end

  test "#update_password will not change password when current_password is incorrect" do
    user = users(:confirmed)
    params = { user: { password: "newpassword", password_confirmation: "newpassword2", current_password: "wrongpassword" } }

    sign_in_as(user)
    patch profile_password_url, params: params

    assert_response :unprocessable_entity
    assert_not user.reload.authenticate("newpassword")
  end

  test "#update_password will not change password when password and password_confirmation do not match" do
    user = users(:confirmed)
    params = { user: { password: "newpassword", password_confirmation: "notnewpassword", current_password: "password123" } }

    sign_in_as(user)
    patch profile_password_url, params: params

    assert_response :unprocessable_entity
    assert_not user.reload.authenticate("newpassword")
  end
end
