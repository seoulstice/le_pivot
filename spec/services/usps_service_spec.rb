require 'rails_helper'

describe UspsService do
  describe "instance methods" do
    let(:usps_service) { UspsService.new}

    it "#shipping_cost_api" do
      VCR.use_cassette("shipping_cost_estimate") do
        shipping_estimate = usps_service.get_rate_calculation_api
# binding.pry
        expect(shipping_estimate).to be_a(String)

      end
    end
  end
end
