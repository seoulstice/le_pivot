FactoryBot.define do
  factory :order_item do
    order
    item
    
    quantity { rand(5) }
  end
end
