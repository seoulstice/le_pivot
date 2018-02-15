require 'rails_helper'

RSpec.describe OrderCreator do
  context "when creating an order" do
    it "saves cart#total price to the total price attribute on a Order object" do
      params = {"container_type"=>"SM FLAT RATE BOX", "zip"=>"90201"}
      item_1 = create(:item, price: 1.00)
      item_2 = create(:item, price: 4.95)
      cart = Cart.new( item_1.id => 2, item_2.id => 1 )
      oc = OrderCreator.create_order(create(:user), cart , params )

      expect(oc.total_price).to eq(6.95)
    end
  end
end
