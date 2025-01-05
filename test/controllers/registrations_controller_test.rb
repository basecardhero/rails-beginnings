require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_registration_url
    assert_response :success
  end

  test "should create a new user" do
    post registrations_url, params: {
        user: {
          email_address: "john.doe.123@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    assert_redirected_to new_session_url
    assert_equal "Your account was successfully created! You may now log in.", flash[:notice]
    assert_not_nil User.find_by(email_address: "john.doe.123@example.com")
  end

  test "should show an error message when email address is invalid" do
    post registrations_url, params: {
        user: {
          email_address: "john.doe.123",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    assert_response :unprocessable_entity
    assert response.body.include?("Email address is invalid")
  end

  test "should show an error message when password is invalid" do
    post registrations_url, params: {
        user: {
          email_address: "john.doe.123@example.com",
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
          email_address: "john.doe.123@example.com",
          password: "password123",
          password_confirmation: "123password"
        }
      }
    assert_response :unprocessable_entity
    assert response.parsed_body.to_html.include?("Password confirmation doesn't match Password")
  end
end
