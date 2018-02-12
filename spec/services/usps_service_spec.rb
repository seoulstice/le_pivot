require 'rails_helper'

describe UspsService do
  describe "instance methods" do
    let(:usps_service) { UspsService.new}

    it "#shipping_cost_api" do
      VCR.user_cassette("shipping_cost_estimate") do
        
      end
    end
  end
end
