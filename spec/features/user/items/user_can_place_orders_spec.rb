require 'rails_helper'

RSpec.feature "User can place an order" do
  it "and see the message 'order was successfully placed'" do

    item = create(:item)
    stub_logged_in_user
    visit item_path(item)
    click_on "Add to cart"
    visit cart_path
    click_on "Checkout"

    expect(current_path).to eq(new_charge_path)
    expect(page).to have_content("Amount: $#{item.price}")
  end
end
