require 'http_client'
module Geocoder
  class GoogleGeocoder
    BASE_URL = "http://maps.googleapis.com/maps/api/geocode/json"
    RESPONSES = {:ok => "OK", :empty => "ZERO_RESULTS", :over_limit => "OVER_QUERY_LIMIT", :denied => "REQUEST_DENIED", :invalid => "INVALID_REQUEST"}

    def geocode(street_address, city, country)
      http_client = HttpClient.new
      response = http_client.get(BASE_URL, params(street_address, city, country))
      response = parse_response(response)
      status = response['status']
      validate_status(status)
      latlng = response['results'].first['geometry']['location']
      return latlng['lat'], latlng['lng']
    end
    
    private
      def params(street_address, city, country)
        {:address => "#{street_address},#{city}", :region => country, :sensor => false}
      end
      
      def parse_response(response)
        begin
          JSON.parse(response)
        rescue JSON::ParserError => e
          raise GeocoderError, e
        end
      end

      def validate_status(status)
        case status
        when RESPONSES[:ok] 
          return
        when RESPONSES[:empty]
          raise EmptyResultsError, "No results found with given address."
        when RESPONSES[:over_limit] # indicates that you are over your quota.
          raise OverQueryLimitError, "Google Geocoding API query limit exceeded."
        when RESPONSES[:denied] # indicates that your request was denied, generally because of lack of a sensor parameter.
          raise RequestDeniedError, "Request denied. Check that URL is correct."
        when RESPONSES[:invalid] # generally indicates that the query (address or latlng) is missing.
          raise InvalidRequestError, "Request was invalid."
        else
          raise GeocoderError, "Got an response #{status} from Google. Don't understand it."
        end
      end
  end
end