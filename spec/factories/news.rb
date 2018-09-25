FactoryBot.define do
  factory :news do
    sequence(:title) { |n| Faker::Book.title << n }
    body { Faker::Lorem.sentence }
    language { 'English' }
  end
end
