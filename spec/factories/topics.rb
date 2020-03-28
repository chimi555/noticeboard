FactoryBot.define do
  factory :topic do
    sequence(:title) { |n| "Testトピック#{n}" }
    sequence(:description) { |n| "Testトピック#{n}について語るスレです。" }
    association :user
  end
end
