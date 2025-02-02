require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "the home page exists" do
    get root_url

    assert_response :success
  end
end
