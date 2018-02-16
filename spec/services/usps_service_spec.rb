require 'rails_helper'

describe UspsService do
  describe "instance methods" do
    let(:usps_service) { UspsService.new({"container_type"=>"SM FLAT RATE BOX", "zip"=>"90201"}) }
    response = "7.20"



    it "#shipping_cost_api" do
      allow_any_instance_of(UspsService).to receive(:get_rate_calculation_api).and_return(response)
      shipping_estimate = usps_service.get_rate_calculation_api

      expect(shipping_estimate).to be_a(String)
    end
  end
end
