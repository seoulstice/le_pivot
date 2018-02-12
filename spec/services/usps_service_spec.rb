require 'rails_helper'

describe UspsService do
  describe "instance methods" do
<<<<<<< HEAD
    let(:usps_service) { UspsService.new({"container_type"=>"SM FLAT RATE BOX", "zip"=>"90201"}) }

    it "#shipping_cost_api" do
      VCR.use_cassette("shipping_cost_estimate") do
        shipping_estimate = usps_service.get_rate_calculation_api

        expect(shipping_estimate).to be_a(String)
=======
    let(:usps_service) { UspsService.new}

    it "#shipping_cost_api" do
      VCR.user_cassette("shipping_cost_estimate") do
        
>>>>>>> Create usps_service_spec
      end
    end
  end
end
