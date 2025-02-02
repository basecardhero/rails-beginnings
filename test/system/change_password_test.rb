require "application_system_test_case"

class ChangePasswordTest < ApplicationSystemTestCase
  test "a user can change their password" do
    sign_in_as(:one)

    visit profile_url
    fill_in "Current password", with: "password123"
    fill_in "New password", with: "newpassword"
    fill_in "Confirm new password", with: "newpassword"
    click_on "Change Password"

    assert_text "Password updated"
  end

  test "a user sees an error message when they try to change their password with invalid password confirmation" do
    sign_in_as(:one)

    visit profile_url
    fill_in "New password", with: "newpassword"
    fill_in "Confirm new password", with: "notnewpassword"
    fill_in "Current password", with: "password123"
    click_on "Change Password"

    assert_text "Password confirmation doesn't match Password"
  end

  test "a user sees an error message when they try to change their password with invalid current password" do
    sign_in_as(:one)

    visit profile_url
    fill_in "New password", with: "newpassword"
    fill_in "Confirm new password", with: "newpassword"
    fill_in "Current password", with: "notcurrentpassword"
    click_on "Change Password"

    assert_text "Current password is incorrect"
  end
end
