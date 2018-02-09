require 'rails_helper'

describe OrderItem do
  it "::average_quantity" do
    create(:order_item, quantity: 1)
    create(:order_item, quantity: 3)

    expect(OrderItem.average_quantity).to eq(2)
  end
end
