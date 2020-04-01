FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "tester#{n}_username" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { 'foobar' }
    role { :normal }
  end

  trait :test do
    role { :test }
    name { "テストユーザー" }
    email { "testuser@example.com" }
    password { "testuser" }
  end

  trait :admin do
    role { :admin }
    name { "adminユーザー" }
    email { "adminuser@example.com" }
    password { "adminuser" }
  end
end
