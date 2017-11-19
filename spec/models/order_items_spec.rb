require 'rails_helper'

describe "order item methods" do
  it "returns the quantity for an item associated with an order" do
    item_1 = create(:item)
    item_2 = create(:item)
    order_1 = create(:order, items: [item_1, item_2])
    order_2 = create(:order, items: [item_1])
    expected_result = {item_1.id => 2, item_2.id => 1}
    quantity_hash = OrderItem.sum_quantity.count
    expect(quantity_hash).to eq(expected_result)
  end

  it "can return top three items" do
    item_1 = create(:item)
    item_2 = create(:item)
    item_3 = create(:item)
    item_4 = create(:item)
    order_1 = create(:order)
    order_2 = create(:order)

    2.times do
      order_1.items << item_1
      order_2.items << item_2
      order_2.items << item_4
    end

    order_2.items << item_3

    top_items = OrderItem.top_three_items
    expect(top_items.count).to eq(3)
    expect(top_items).to include(item_1)
    expect(top_items).to include(item_2)
    expect(top_items).to include(item_4)
    expect(top_items).to_not include(item_3)
  end

  it "can average quantity" do
    item_1 = create(:item)
    item_2 = create(:item)
    order_1 = create(:order)
    order_2 = create(:order)

    OrderItem.create(item: item_1, quantity: 1, order: order_1)
    OrderItem.create(item: item_2, quantity: 3, order: order_2)

    expect(OrderItem.average_quantity).to eq(2)
  end
end
