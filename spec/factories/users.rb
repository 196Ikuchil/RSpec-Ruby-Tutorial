FactoryBot.define do
  factory :user do
    name { "Example User" }
    email { "user@example.com" }
    password {"foobar"}
    password_confirmation {"foobar"}
    admin {false}
    activated {true}
    activated_at {Time.zone.now}

    factory :other_user do
      name {Faker::Name.name}
      email {Faker::Internet.email}
    end

    trait :invalid do
      name {nil}
      email {"foo@invalid"}
      password {"foo"}
      password_confirmation {"bar"}
      admin{false}
      activated {true}
      activated_at {Time.zone.now}
    end

    trait :not_activated do
      activated {false}
      activated_at {nil}
    end

    trait :michael do
      name{"Michael Example"}
      email{"michael@example.com"}
      password{"foobarM"}
      password_confirmation{"foobarM"}
      admin {true}
      activated {true}
      activated_at {Time.zone.now}
    end

    trait :archer do
      name {"Sterling Archer"}
      email {"duchess@example.gov"}
      password {"foobarA"}
      password_confirmation {"foobarA"}
      activated {true}
      activated_at {Time.zone.now}
    end

    trait :lana do
      name {"Lana Kane"}
      email {"hands@example.gov"}
      password {"foobarL"}
      password_confirmation {"foobarL"}
      activated {true}
      activated_at {Time.zone.now}
    end

    trait :malory do
      name {"Malory Archer"}
      email {"boss@example.gov"}
      password {"foobarMA"}
      password_confirmation {"foobarMA"}
      activated {true}
      activated_at {Time.zone.now}
    end
  end
end
