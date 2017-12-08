FactoryBot.define do
  factory :order do
    status 1
    user

    transient do
      items_with_quantity [{create(:item) => 1}]
    end

    factory :order_with_items do
      after(:create) do |order, evaluator|
        evaluator.items_with_quantity.each do |item_with_quantity|
          item     = item_with_quantity.keys.first
          quantity = item_with_quantity.values.first
          create(:order_item, order: order, item: item, quantity: quantity)
        end
      end
    end

  end
end
