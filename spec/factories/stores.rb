FactoryBot.define do
  factory :store do
    name { Faker::Company.name }
    slug { name.parameterize }
  end
end
