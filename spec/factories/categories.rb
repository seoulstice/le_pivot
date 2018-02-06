FactoryBot.define do
  factory :category do
    title { Faker::Commerce.department }
  end
end
