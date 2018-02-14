FactoryBot.define do
  factory :order do
    user

    total_price { rand(1000) / 100.0 }
  end
end
