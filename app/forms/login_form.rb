class LoginForm
  include ActiveModel::Model

  attr_accessor :password
  attr_reader :email

  validates_presence_of :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, if: -> { email.present? }
  validates :password, presence: true

  def email=(email)
    if email.present?
      @email = email.strip.downcase
    else
      @email = email
    end
  end
end
