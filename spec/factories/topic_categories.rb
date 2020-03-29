FactoryBot.define do
  factory :topic_category do
    association :topic
    association :category
  end
end
