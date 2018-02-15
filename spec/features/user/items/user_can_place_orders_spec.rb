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
    save_and_open_page

<<<<<<< HEAD
    expect(current_path).to eq(new_charge_path)
    expect(page).to have_content("Amount: $#{item.price}")
  end
<<<<<<< HEAD
  it "and validate shipping address on cart page" do
    visit cart_path

    fill_in "usps[address2]", with: "2301 Clay St"
    fill_in "usps[city]", with: "Denver"
    fill_in "usps[state]", with: "CO"
    fill_in "usps [zip_code]", with: "80211"









=======
    expect(current_path).to eq(orders_path)
    expect(page).to have_content("Order was successfully placed")
>>>>>>> Temp skipped specs
  end
=======
>>>>>>> Migration to add column to orders total_price_with_shipping

  xit "and estimate shipping cost" do
    visit cart_path

    choose("container_type_SM_FLAT_RATE_BOX", visible: false)
    fill_in "zip", with: "90210"
    click_on "Calculate Shipping Cost"
    click_on "Checkout"
    expect(current_path).to eq(orders_path)
  end
end
