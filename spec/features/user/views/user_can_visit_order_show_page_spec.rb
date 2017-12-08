require 'rails_helper'

describe "As a user" do
  describe "visits /orders" do
    it "can see all past orders" do
      user = create(:user)
      item = create(:item, price: 5.00)
      items_with_quantity = [ {item => 2} ]
      order = create(:order_with_items, user: user, items_with_quantity: items_with_quantity)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit '/orders'
      click_on order.id

      expect(current_path).to eq(order_path(order))
      expect(page).to have_content("Total: $10.00")
    end
  end
end
