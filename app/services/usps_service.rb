class UspsService
  require "net/http"
  require "uri"

  attr_reader :params

  def get_rate_calculation_api
    get_xml("/ShippingAPI.dll", usps_shipping_rate_params )
    binding.pry
  end

  private
    attr_reader :shipping_params,
                :usps_service_types

    def conn
      Faraday.new(url: "http://production.shippingapis.com") do |faraday|
        faraday.adapter Faraday.default_adapter
      end
    end

    def get_xml(url, query = {})
      response = conn.get(url, query)
      binding.pry
      Nokogiri::XML(response.body)
    end

    def usps_shipping_rate_params
      {API: "RateV4",
       XML: xml_shipping_rate_request_params
      }
    end

    def xml_shipping_rate_request_params
      shipping_config = "<?xml version='1.0' encoding='UTF-8'?>
                        <RateV4Request USERID=#{ENV["USPS_KEY"]}>
                          <Package ID='1ST'>
                            <Service>PRIORITY</Service>
                            <ZipOrigination>80211</ZipOrigination>
                            <ZipDestination>19072</ZipDestination>
                            <Pounds>#{[1..10].sample}</Pounds>
                            <Ounces>#{[1..15].sample}</Ounces>
                            <Container>NONRECTANGULAR</Container>
                            <Size>LARGE</Size>
                            <Width>15</Width>
                            <Length>30</Length>
                            <Height>15</Height>
                            <Girth>55</Girth>
                          </Package>
                        </RateV4Request>"
      Nokogiri::XML(shipping_config)
    end

    def usps_service_types
      ["PRIORITY", "PRIORITY MAIL EXPRESS"]
    end



end
