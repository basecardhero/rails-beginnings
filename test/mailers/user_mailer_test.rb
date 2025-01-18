require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  include Rails.application.routes.url_helpers

  test "confirm_email" do
    @user = users(:one)
    mail = UserMailer.confirm_email(@user)

    assert_emails 1 do
      mail.deliver_now
    end

    assert_equal "Email Confirmation", mail.subject
    assert_equal [ @user.email_address ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert mail.text_part.body.to_s.include? "Welcome!"
    assert mail.text_part.body.to_s.include? "Please visit the url below to confirm your email address."
    assert mail.text_part.body.to_s.include? confirm_registrations_url ""
    assert mail.html_part.body.to_s.include? "Welcome!"
    assert mail.html_part.body.to_s.include? "Please click the link below to confirm your email address."
    assert mail.html_part.body.to_s.include? "Confirm my email"
    assert mail.html_part.body.to_s.include? confirm_registrations_url ""
  end
end
