require "application_system_test_case"

class LogOutTest < ApplicationSystemTestCase
  test "a user can log out" do
    user = users(:confirmed)
    sign_in_as(user)

    assert_text "Logout"
    click_on "Logout"

    assert_current_path root_url
    assert_text "Login"
    assert_text "Register"
  end
end
