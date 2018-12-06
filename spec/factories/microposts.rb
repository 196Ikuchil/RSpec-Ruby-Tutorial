FactoryBot.define do
  factory :micropost do
    content { Faker::Lorem.sentence(5)}
    association :user, factory: :user
    factory :other_micropost do
      content {Faker::Lorem.sentence(5)}
      created_at {42.days.ago}
      association :user, factory: :other_user
    end

    trait :most_recent do
      created_at {Time.zone.now}
    end
    trait :ten_minutes_ago do
      created_at {10.minutes.ago}
    end
    trait :two_hours_ago do
      created_at {2.hours.ago}
    end
    trait :three_years_ago do
      created_at {3.years.ago}
    end
  end
end
