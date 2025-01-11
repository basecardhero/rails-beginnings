class NewSessionForm < ApplicationForm
  attribute(:email_address, :string)
  attribute(:password, :string)

  normalizes :email_address, with: ->(email_address) { email_address.strip.downcase }

  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP, message: "is invalid" }
  validates :password, presence: true

  def initialize(attributes = {})
    super(**attributes)
  end
end
