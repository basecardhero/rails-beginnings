class UserMailer < ApplicationMailer
  # Sends an email to confirm the user's email address.
  #
  # @param user [User] the user to send the confirmation email to
  # @return [Mail::Message] the email message that was sent
  def confirm_email(user)
    @user = user

    mail to: @user.email_address, subject: "Email Confirmation"
  end
end
