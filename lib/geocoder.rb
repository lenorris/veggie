require "net/http"
require "uri"

module Geocoder
  
  
  def self.get_latlng(address)
    
    return mock_answer if Rails.env.test?
    
    url_encoded_address = URI.encode(address)
    base_uri = ("http://maps.googleapis.com/maps/api/geocode/json?address=#{url_encoded_address}&sensor=false&region=fi")
    uri = URI.parse(base_uri)
    response = JSON.parse(Net::HTTP.get(uri))
    case response['status']
    when "OK" # indicates that no errors occurred; the address was successfully parsed and at least one geocode was returned.
      results = response['results']
      if results.size == 1
        latlng = results.first['geometry']['location']
        return latlng['lat'], latlng['lng']
      else
        raise AddressAmbiguousError
      end
    when "ZERO_RESULTS" # indicates that the geocode was successful but returned no results.
      raise EmptyResultsError, "No results found with given address."
    when "OVER_QUERY_LIMIT" # indicates that you are over your quota.
      raise OverQueryLimitError, "Google Geocoding API query limit exceeded."
    when "REQUEST_DENIED" # indicates that your request was denied, generally because of lack of a sensor parameter.
      raise RequestDeniedError, "Request denied. Check that URL is correct. URL was #{base_uri}"
    when "INVALID_REQUEST" # generally indicates that the query (address or latlng) is missing.
      raise InvalidRequestError, "Request was invalid. Check that URL is correct. URL was #{base_uri} "
    end
    
  end

  # Errors thrown (TODO: rethink this, might not be the best way to handle this)
  class GeocoderError < StandardError
  end
  class AddressAmbiguousError < GeocoderError
  end
  class EmptyResultsError < GeocoderError
  end
  class OverQueryLimitError < GeocoderError
  end
  class RequestDeniedError < GeocoderError
  end
  class InvalidRequestError < GeocoderError
  end
  
  private
  
  def self.mock_answer
    [60.16794829999999, 24.93563410]
  end
  
end


