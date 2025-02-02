ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Signs in a user by posting to the session path with the user's email and password.
    #
    # @param user [User, Symbol] the user to sign in, or a symbol representing a user fixture
    # @return [void]
    def sign_in_as(user, password: "password123")
      user = users(user) unless user.is_a? User
      post session_path, params: { new_session_form: { email_address: user.email_address, password: } }
    end

    # Signs out the current user by deleting the session.
    #
    # @return [void]
    def sign_out
      delete session_path
    end

    # Parses the cookies from the request.
    #
    # @return [ActionDispatch::Cookies::CookieJar] the parsed cookies
    def parsed_cookies
      ActionDispatch::Cookies::CookieJar.build(request, cookies.to_hash)
    end
  end
end
