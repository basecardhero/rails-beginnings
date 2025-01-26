require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest
  test "#index exists" do
    user = users(:one)
    sign_in(user)

    get profile_url

    assert_response :success
  end

  test "#update updates the user" do
    user = users(:one)
    sign_in(user)
    params = { user: { username: "newusername", email_address: "new.email@example.com" } }

    patch profile_url, params: params
    user.reload

    assert_redirected_to profile_url
    assert_equal "Profile updated", flash[:notice]
    assert_equal params[:user][:username], user.username
    assert_equal params[:user][:email_address], user.email_address
  end

  test "#update with render :index when user is invalid" do
    user = users(:one)
    sign_in(user)
    params = { user: { email_address: "new.email@example.com" } }

    patch profile_url, params: params

    assert_response :unprocessable_entity
  end

  test "#update requires email confirmation" do
    user = users(:unconfirmed)
    sign_in(user)
    params = { user: { email_address: "different.email@example.com", username: "DifferentUsername" } }

    patch profile_url, params: params
    user.reload()

    assert_redirected_to profile_url
    assert_equal "Email address not confirmed. Please check your email for a confirmation link.", flash[:alert]
    assert_not_equal params[:user][:username], user.username
    assert_not_equal params[:user][:email_address], user.email_address
  end
end
