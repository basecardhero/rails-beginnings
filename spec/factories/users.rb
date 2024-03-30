FactoryBot.define do
  factory :user do
    username { Faker::Alphanumeric.alpha(number: 10) }
    email { Faker::Internet.email }
    password { "password123" }
  end
end
