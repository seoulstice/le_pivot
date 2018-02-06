FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name  }
    last_name { Faker::Name.last_name }
    password "password"
    sequence(:email) {|n| "gob#{n}@example.com" }

    factory(:admin) do
      password "password"
      role "admin"
      sequence(:email) {|n| "admin-#{n}@example.com" }
    end
  end
end
