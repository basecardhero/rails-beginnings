class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  validates :email_address,
    format: { with: URI::MailTo::EMAIL_REGEXP, message: "is invalid" },
    uniqueness: { case_sensitive: true }
  validates :username,
    format: { with: /\A[a-zA-Z0-9]*\z/, message: "must contain only letters and numbers" },
    uniqueness: { case_sensitive: false },
    length: { minimum: 7, maximum: 20 }
  validates :password,
    length: { minimum: 10 },
    confirmation: true,
    if: -> { new_record? || changes[:password_digest] }

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  normalizes :username, with: ->(e) { e.strip }

  generates_token_for :email_confirmation, expires_in: 1.day do
    confirmed_at
  end
end
