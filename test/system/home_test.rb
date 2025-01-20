require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  test "home page has the text" do
    visit root_url

    assert_text "Rails Beginnings"
    assert_text "A beginner Rails web application to learn Ruby and Rails!"
  end
end
