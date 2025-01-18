class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  validates :email_address,
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "is invalid" },
    uniqueness: { case_sensitive: true }
  validates :password,
    length: { minimum: 10 },
    confirmation: true,
    if: -> { new_record? || changes[:password_digest] }

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  generates_token_for :email_confirmation, expires_in: 1.day do
    confirmed_at
  end
end
