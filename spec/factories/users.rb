FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "tester#{n}_username" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'foobar' }
  end
end
