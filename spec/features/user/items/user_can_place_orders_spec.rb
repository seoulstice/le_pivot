require 'rails_helper'

RSpec.feature "User can place an order" do
  it "and see the message 'order was successfully placed'" do

    item = create(:item)
    stub_logged_in_user
    visit item_path(item)
    click_on "Add to cart"
  end

  it "and after placing order, sees message 'order was successfully placed" do
    visit cart_path
    click_on "Checkout"

    expect(current_path).to eq(new_charge_path)
    expect(page).to have_content("Amount: $#{item.price}")
  end
  it "and validate shipping address on cart page" do
    visit cart_path

    fill_in "usps[address2]", with: "2301 Clay St"
    fill_in "usps[city]", with: "Denver"
    fill_in "usps[state]", with: "CO"
    fill_in "usps [zip_code]", with: "80211"









  end

  it "and estimate shipping cost" do


  end
end
