require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "new" do
    get new_session_url
    assert_response :success
  end

  test "create with valid credentials" do
    post session_url, params: { new_session_form: { email_address: "one@example.com", password: "password" } }

    assert_redirected_to root_url
    assert parsed_cookies.signed[:session_id]
    assert_nil flash[:alert]
  end

  test "create with invalid credentials" do
    post session_url, params: { new_session_form: { email_address: "one@example.com", password: "wrong" } }

    assert_redirected_to new_session_url
    assert_nil parsed_cookies.signed[:session_id]
    assert_equal "Invalid email or password.", flash[:alert]
  end

  test "create will show validation errors" do
    post session_url, params: { new_session_form: { email_address: "one@example.com", password: "wrong" } }

    assert_redirected_to new_session_url
    assert_nil parsed_cookies.signed[:session_id]
    assert_equal "Invalid email or password.", flash[:alert]
  end

  test "create will show form errors" do
    post session_url, params: { new_session_form: { email_address: "ad.ee.com" } }

    assert_response :unprocessable_entity
    assert response.parsed_body.to_html.include?("Email address is invalid")
    assert response.parsed_body.to_html.include?("Password can't be blank")
  end

  test "destroy" do
    sign_in :one

    delete session_url

    assert_redirected_to new_session_url
    assert_empty cookies[:session_id]
  end
end
