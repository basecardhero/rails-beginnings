class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    mail subject: "Reset your password", to: user.email_address
  end

  def changed(user)
    @user = user
    mail subject: "Password Changed", to: user.email_address
  end
end
