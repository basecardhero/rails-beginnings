require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase
  test "registering a new user" do
    visit new_registration_url

    fill_in "Email", with: "john.doe@example.com"
    fill_in "Username", with: "JohnDoe123"
    fill_in "Password", with: "password123"
    fill_in "Confirm password", with: "password123"

    click_on "Register"

    assert_current_path new_session_url
    assert_text "You have successfully registered! Please check your email to confirm your email address."
  end

  test "when password and password confirmation do not match, it will display the error message" do
    visit new_registration_url

    fill_in "Email", with: "john.doe@example.com"
    fill_in "Username", with: "JohnDoe123"
    fill_in "Password", with: "password123"
    fill_in "Confirm password", with: "NOT_password123"

    click_on "Register"

    assert_current_path new_registration_url
    assert_text "Password confirmation doesn't match Password"
  end

  test "when an existing email address is used, it will display the error message" do
    visit new_registration_url

    fill_in "Email", with: users(:confirmed).email_address
    fill_in "Username", with: "JohnDoe123"
    fill_in "Password", with: "password123"
    fill_in "Confirm password", with: "password123"

    click_on "Register"

    assert_current_path new_registration_url
    assert_text "Email address has already been taken"
  end

  test "when an existing username is used, it will display the error message" do
    visit new_registration_url

    fill_in "Email", with: "john.doe@example.com"
    fill_in "Username", with: users(:confirmed).username
    fill_in "Password", with: "password123"
    fill_in "Confirm password", with: "password123"
    click_on "Register"

    assert_current_path new_registration_url
    assert_text "Username has already been taken"
  end

  test "email confirmation when successfull" do
    user = users(:unconfirmed)
    visit confirm_registrations_url(user.generate_token_for(:email_confirmation))

    assert_current_path new_session_url
    assert_text "Your email has been confirmed. You may now log in."
  end

  test "email confirmation token is expired or invalid" do
    visit confirm_registrations_url("not_a_valid_token")

    assert_current_path new_session_url
    assert_text "The confirmation link is invalid or expired."
  end

  test "clicking on 'Already have an account?' will take you to the log in page" do
    visit new_registration_url

    click_on "Already have an account?"

    assert_current_path new_session_url
  end
end
