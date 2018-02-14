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
     "<RateV4Request USERID=#{ENV['USPS_KEY"]}>
        <Package ID='1ST'>
          <Service>#{usps_service_types.sample}</Service>
          <ZipOrigination>80211</ZipOrigination>
          <ZipDestination>19072</ZipDestination>
          <Pounds>2</Pounds>
          <Ounces>5</Ounces>
          <Container>NONRECTANGULAR</Container>
          <Size>LARGE</Size>
          <Width>15</Width>
          <Length>30</Length>
          <Height>15</Height>
          <Girth>55</Girth>
        </Package>
      </RateV4Request>"
    end

    def usps_service_types
      ["PRIORITY", "PRIORITY MAIL EXPRESS"]
    end

    def destination_zip
      params[zip_destination]
    end
end
