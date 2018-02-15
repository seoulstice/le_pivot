require 'rails_helper'

<<<<<<< HEAD
RSpec.feature "User can place an order" do
  it "and see the message 'order was successfully placed'" do

    item = create(:item)
    stub_logged_in_user
    visit item_path(item)
=======
RSpec.feature "A User can add item to cart" do
  before :each do
    @item = create(:item, price: "2.00")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(create(:user))
    visit item_path(@item.id)
>>>>>>> Migration to add column to orders total_price_with_shipping
    click_on "Add to cart"
  end

  it "and after placing order, sees message 'order was successfully placed" do
      visit cart_path
      click_on "Checkout"

      expect(current_path).to eq(new_charge_path)
    end
  end
<<<<<<< HEAD
  it "and validate shipping address on cart page" do
    visit cart_path

    fill_in "usps[address2]", with: "2301 Clay St"
    fill_in "usps[city]", with: "Denver"
    fill_in "usps[state]", with: "CO"
    fill_in "usps [zip_code]", with: "80211"









  end
=======
>>>>>>> Migration to add column to orders total_price_with_shipping

  it "and estimate shipping cost" do
    visit cart_path

    choose("container_type_SM_FLAT_RATE_BOX", visible: false)
    fill_in "zip", with: "90210"
    click_on "Calculate Shipping Cost"

    expect(page).to have_content("Shipping Estimate: $7.20")
    expect(page).to have_content("Total: $9.20")

    end
end
