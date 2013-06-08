require 'http_client'
require 'google_parser'
module Geocoder
  class GoogleGeocoder
    BASE_URL = "http://maps.googleapis.com/maps/api/geocode/json"

    def geocode(street_address, city, country)
      response = http_client.get(BASE_URL, params(street_address, city, country))
      return parser.parse(response)
    end
    
    private
      def params(street_address, city, country)
        {:address => "#{street_address},#{city}", :region => country, :sensor => false}
      end

      def http_client()
        HttpClient.new
      end

      def parser()
        Geocoder::GoogleParser.new
      end
    end
end