class UspsService
  require 'faraday_middleware'
  attr_reader :params

  def initialize
    @params = params
  end

  def get_rate_calculation_api
    get_xml("/ShippingApi.dll", usps_shipping_rate_params )
  end

  private
    attr_reader :usps_shipping_rate_params,
                :usps_service_types

    def conn
      Faraday.new(url: "http://production.shippingapis.com") do |faraday|
        faraday.response :xml,  :content_type => /\bxml$/
        faraday.adapter Faraday.default_adapter
      end
    end

    def get_xml(url, query_params = {})
      response = conn.get(url, query_params)
      binding.pry
    end

    def usps_shipping_rate_params
      {API: "RateV4",
       XML: xml_shipping_rate_request_params
      }
    end

    def xml_shipping_rate_request_params
      # binding.pry
     "<RateV4Request USERID='#{ENV["USPS_KEY"]}'>
        <Package ID='1ST'>
          <Service>#{usps_service_types}</Service>
          <ZipOrigination>80211</ZipOrigination>
          <ZipDestination>#{destination_zip}</ZipDestination>
          <Pounds>#{random_pounds}</Pounds>
          <Ounces>#{random_ounces}</Ounces>
          <Container>#{random_container}</Container>
          <Size>REGULAR</Size>
        </Package>
      </RateV4Request>"
    end

    def usps_service_types
      ["PRIORITY", "PRIORITY MAIL EXPRESS"].sample
      # params[service_type]
    end

    def destination_zip
      # params[zip_destination]
      19072
    end

    def random_pounds
      (1..70).to_a.sample
    end

    def random_ounces
      (1...16).to_a.sample
    end

    def random_container
      ["SM FLAT RATE BOX", "MD FLAT RATE BOX",
      "LG FLAT RATE BOX"].sample
    end
end
