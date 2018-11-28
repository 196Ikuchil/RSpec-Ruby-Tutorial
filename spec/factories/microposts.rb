FactoryBot.define do
  factory :micropost do
    content { "MyText" }
    user { nil }
    trait :most_recent do
      created_at {Time.zone.now}
    end
  end
end
