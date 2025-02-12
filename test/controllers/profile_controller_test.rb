require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "#index exists" do
    sign_in_as(:confirmed)

    get profile_url

    assert_response :success
  end

  test "#update updates the user" do
    user = users(:confirmed)
    params = { user: { username: "newusername" } }

    sign_in_as(user)
    patch profile_url, params: params
    user.reload

    assert_redirected_to profile_url
    assert_equal "Profile updated", flash[:notice]
    assert_equal params[:user][:username], user.username
  end

  test "#update with render :index when user is invalid" do
    params = { user: { username: "bad.username!" } }

    sign_in_as(:confirmed)
    patch profile_url, params: params

    assert_response :unprocessable_entity
  end

  test "#update requires email confirmation" do
    user = users(:unconfirmed)
    params = { user: { username: "DifferentUsername" } }

    sign_in_as(user)
    patch profile_url, params: params
    user.reload()

    assert_redirected_to profile_url
    assert_equal "Email address not confirmed. Please check your email for a confirmation link.", flash[:alert]
    assert_not_equal params[:user][:username], user.username
  end

  test "#update_email updates the user's email address" do
    user = users(:confirmed)
    params = { user: { email_address: "new.email@example.com" } }

    sign_in_as(user)
    assert_enqueued_emails 1 do
      patch profile_email_url, params: params
    end

    user.reload
    assert_redirected_to profile_url
    assert_equal "Email address updated", flash[:notice]
    assert_equal params[:user][:email_address], user.email_address
    assert_nil user.confirmed_at
  end

  test "#update_email with render :index when user is invalid" do
    params = { user: { email_address: "" } }

    sign_in_as(:confirmed)
    patch profile_email_url, params: params

    assert_response :unprocessable_entity
  end

  test "#update_email requires confirmed email" do
  user = users(:unconfirmed)
  params = { user: { email_address: "new.email@example.com" } }

  sign_in_as(user)
  patch profile_email_url, params: params

  assert_redirected_to profile_url
  assert_equal "Email address not confirmed. Please check your email for a confirmation link.", flash[:alert]
  assert_not_equal params[:user][:email_address], user.reload.email_address
  end

  test "#send_email_confirmation sends a confirmation email" do
    sign_in_as(:unconfirmed)
    assert_enqueued_emails 1 do
      patch profile_send_email_confirmation_url
    end

    assert_redirected_to profile_url
    assert_equal "Confirmation email sent. Please check your email.", flash[:notice]
  end

  test "#send_email_confirmation does not send a confirmation email if the email is already confirmed" do
    sign_in_as(:confirmed)
    assert_no_enqueued_emails do
      patch profile_send_email_confirmation_url
    end

    assert_redirected_to profile_url
    assert_equal "Email address already confirmed.", flash[:alert]
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
