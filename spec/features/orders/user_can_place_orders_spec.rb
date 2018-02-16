require 'rails_helper'

RSpec.feature "User can place an order" do

  it "and estimate shipping cost" do
    VCR.use_cassette("shipping_feature") do
      user = create(:user, first_name: "Gob")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      allow_any_instance_of(UspsService).to receive(:get_rate_calculation_api).and_return("7.20")

      visit cart_path

      choose("container_type_SM_FLAT_RATE_BOX", visible: false)
      fill_in "zip", with: "90210"
      click_on "Calculate Shipping Cost"

      expect(current_path).to eq(new_charge_path)
    end
  end
end
