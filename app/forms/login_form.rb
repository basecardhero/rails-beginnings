class LoginForm
  include ActiveModel::Model

  attr_accessor :password
  attr_reader :email

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true

  def email=(email)
    @email = email.strip.downcase
  end
end
