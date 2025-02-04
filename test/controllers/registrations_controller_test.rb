require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_registration_url

    assert_response :success
  end

  test "should create a new user" do
    assert_emails 1 do
      post registrations_url, params: {
        user: {
          email_address: "new.user@example.com",
          username: "NewUser123",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_redirected_to new_session_url
    assert_equal "You have successfully registered! Please check your email to confirm your email address.", flash[:notice]
    assert_not_nil User.find_by(email_address: "new.user@example.com")
  end

  test "should show an error message when email address is invalid" do
    post registrations_url, params: {
        user: {
          email_address: "new.user",
          username: "NewUser123",
          password: "password123",
          password_confirmation: "password123"
        }
      }

    assert_response :unprocessable_entity
    assert response.body.include?("Email address is invalid")
  end

  test "should show an error message when username is invalid" do
    post registrations_url, params: {
        user: {
          email_address: "new.user@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }

    assert_response :unprocessable_entity
    assert response.body.include?("Username is too short (minimum is 7 characters)")
  end

  test "should show an error message when password is invalid" do
    post registrations_url, params: {
        user: {
          email_address: "new.user@example.com",
          password: "password",
          password_confirmation: "password123"
        }
      }

    assert_response :unprocessable_entity
    assert response.body.include?("Password is too short (minimum is 10 characters)")
  end

  test "should show an error message when password_confirmation is invalid" do
    post registrations_url, params: {
        user: {
          email_address: "new.user@example.com",
          password: "password123",
          password_confirmation: "123password"
        }
      }

    assert_response :unprocessable_entity
    assert response.parsed_body.to_html.include?("Password confirmation doesn't match Password")
  end

  test "confirm a successful email confirmation" do
    user = users(:confirmed)
    orignal_confirmed_at = user.confirmed_at

    get confirm_registrations_url(user.generate_token_for(:email_confirmation))

    assert_redirected_to new_session_url
    assert_equal "Your email has been confirmed. You may now log in.", flash[:notice]
    assert_not_equal orignal_confirmed_at, user.reload.confirmed_at
  end

  test "confirm will flash a message if invalid token" do
    get confirm_registrations_url("not_a_valid_token")

    assert_redirected_to new_session_url
    assert_equal "The confirmation link is invalid or expired.", flash[:alert]
  end
end
