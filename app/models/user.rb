class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :confirmable

  validates :username, presence: true, alphanumeric: true,
        uniqueness: { case_sensitive: false }, length: { minimum: 6, maximum: 16 }
end
