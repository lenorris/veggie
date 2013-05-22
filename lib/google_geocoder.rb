module Geocoder
  class GoogleGeocoder
    BASE_URL = "https://maps.googleapis.com/maps/api/geocode/json?"
    RESPONSES = {:ok => "OK", :empty => "ZERO_RESULTS", :over_limit => "OVER_QUERY_LIMIT", :denied => "REQUEST_DENIED", :invalid => "INVALID_REQUEST"}

    
    def geocode(street_address, city, country, postal_code)
      response = parse_response(Net::HTTP.get uri(street_address, city, country))
      latlng = response['results'].first['geometry']['location']
      return latlng['lat'], latlng['lng']
    end
    
    private
      def uri(street_address, city, country)
        address = URI.encode("#{street_address},#{city}")
        URI.parse "#{BASE_URL}address=#{address}&region=#{country}&sensor=false"
      end
      
      def parse_response(response)
        begin
          JSON.parse(response)
        rescue JSON::ParserError => e
          raise GeocoderError, e
        end
      end
  end
end