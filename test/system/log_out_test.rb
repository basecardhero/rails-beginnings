require "application_system_test_case"

class LogOutTest < ApplicationSystemTestCase
  test "a user can log out" do
    sign_in_as(:confirmed)
    visit root_url
    click_on "Logout"

    assert_current_path new_session_url
  end
end
