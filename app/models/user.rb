class User < ApplicationRecord
  has_secure_password

  normalizes :username, with: -> username { username.strip }
  normalizes :email, with: -> email { email.strip.downcase }

  validates :username, presence: true, length: { in: 6..16 },
              uniqueness: { case_sensitive: false }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
