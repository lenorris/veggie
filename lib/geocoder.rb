require "net/http"
require "uri"
require 'google_geocoder'

module Geocoder
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
  
  def self.get_latlng(street_address, city, country)
    adapters.each do |adapter|
      begin
        return adapter.geocode(street_address, city, country)
      rescue GeocoderError => e
        # TODO: log
      end
    end
    raise GeocoderError, "All geocoder adapters failed."
  end


  
  private
    def self.adapters
      return [Geocoder::GoogleGeocoder.new]
    end
  
end


