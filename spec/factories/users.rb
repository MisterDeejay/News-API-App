FactoryBot.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.email << n }
    password { '123123' }
  end
end
