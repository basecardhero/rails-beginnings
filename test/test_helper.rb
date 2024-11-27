ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def sign_in(user)
      user = users(user) unless user.is_a? User
      post session_path, params: { email_address: user.email_address, password: "password" }
    end

    def sign_out
      delete session_path
    end

    def parsed_cookies
      ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash)
    end
  end
end
