FactoryBot.define do
  factory :user do
    first_name "Gob"
    last_name "Bluth"
    password "password"
    sequence(:email) {|n| "gob#{n}@example.com" }
  end
end

