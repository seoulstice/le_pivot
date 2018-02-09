FactoryBot.define do
  factory :order do
    user

    status 0
    total_price { rand(1000) / 100.0 }
  end
end
