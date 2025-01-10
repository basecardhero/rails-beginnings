require "test_helper"

class PasswordsMailerTest < ActionMailer::TestCase
  include Rails.application.routes.url_helpers

  test "reset" do
    user = users(:one)
    email = PasswordsMailer.reset(user)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [ "from@example.com" ], email.from
    assert_equal [ user.email_address ], email.to
    assert_equal "Reset your password", email.subject
    assert email.text_part.body.to_s.include? "You can reset your password within the next 15 minutes on this password reset page:"
    assert email.text_part.body.to_s["#{root_url}passwords/"]
  end
end
