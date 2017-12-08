FactoryBot.define do
  factory :order_item do
    item
    order
    quantity 1
  end
end
