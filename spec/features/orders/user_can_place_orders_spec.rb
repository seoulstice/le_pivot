require 'rails_helper'

RSpec.feature "User can place an order" do
  it "and see the message 'order was successfully placed'" do

    item = create(:item)
    stub_logged_in_user
    visit item_path(item)
    click_on "Add to cart"
  end

  it "and estimate shipping cost" do
    VCR.use_cassette("shipping_feature") do
      visit cart_path

      choose("container_type_SM_FLAT_RATE_BOX", visible: false)
      fill_in "zip", with: "90210"
      click_on "Calculate Shipping Cost"

      expect(current_path).to eq(new_charge_path)
    end
  end
end