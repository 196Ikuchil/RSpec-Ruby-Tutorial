FactoryBot.define do
  factory :user do
    name { "Example User" }
    email { "user@example.com" }
    password {"foobar"}
    password_confirmation {"foobar"}
    admin {false}

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
    end
  end

  factory :michael,class: User do
    name{"Michael Example"}
    email{"michael@example.com"}
    password{"foobarM"}
    password_confirmation{"foobarM"}
    admin {true}
  end

  factory :archer, class: User do
    name {"Sterling Archer"}
    email {"duchess@example.gov"}
    password {"foobarA"}
    password_confirmation {"foobarA"}
  end

  factory :lana, class: User do
    name {"Lana Kane"}
    email {"hands@example.gov"}
    password {"foobarL"}
    password_confirmation {"foobarL"}
  end

  factory :malory, class:User do
    name {"Malory Archer"}
    email {"boss@example.gov"}
    password {"foobarMA"}
    password_confirmation {"foobarMA"}
  end
end
