FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@email.com" }
    name { "User" }
    password { "password" }
    role { :user }
  end
end
