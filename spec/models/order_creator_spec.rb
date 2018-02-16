require 'rails_helper'

RSpec.describe OrderCreator do
  context "when creating an order" do
    VCR.use_cassette("order_creator_spec") do
      it "saves cart#total price to the total price attribute on a Order object" do
        store = create(:store)
        item_1 = create(:item, price: 1.00, store: store)
        item_2 = create(:item, price: 4.95, store: store)
        cart = Cart.new( item_1.id => 2, item_2.id => 1 )
        oc = OrderCreator.create_order(create(:user), cart, 0.0)

        expect(cart.total_price).to eq(6.95)
      end
    end
  end
end
