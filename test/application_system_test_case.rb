require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  def sign_in_as(user)
    visit new_session_url

    fill_in "Email", with: user.email_address
    fill_in "Password", with: "password123"

    click_on "Log in"

    assert_current_path root_url
  end
end
