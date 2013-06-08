module Geocoder
  class GoogleParser
    RESPONSES = {:ok => "OK", :empty => "ZERO_RESULTS", :over_limit => "OVER_QUERY_LIMIT", :denied => "REQUEST_DENIED", :invalid => "INVALID_REQUEST"}
  	
    def parse(response)
  		response = parse_response(response)
  		validate_status(response)
      results = response['results']
      validate_results(results)
  		latlng = results.first['geometry']['location']
      return latlng['lat'], latlng['lng']
  	end

    private

	   def parse_response(response)
       begin
         JSON.parse(response)
       rescue JSON::ParserError => e
         raise GeocoderError, e
        end
    	end

      def validate_status(response)
        case response['status']
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
          raise GeocoderError, "Got an response #{response['status']} from Google. Don't understand it."
        end
      end

      def validate_results(results)
        raise AddressAmbiguousError if results.size > 1
      end

  end
end