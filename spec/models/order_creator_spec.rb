require 'rails_helper'

RSpec.describe OrderCreator do
  context "when creating an order" do
    it "saves cart#total price to the total price attribute on a Order object" do
      user = create(:user)
      item = create(:item, price: 1.00)
      item_2 = create(:item, price: 4.95)

      cart = Cart.new({item.id => 1, item_2.id => 3})

      total_price = (1 * item.price) + (3 * item_2.price)
      oc = OrderCreator.create_order(user, cart)
      expect(oc.total_price).to eq(total_price)
    end
  end
end
