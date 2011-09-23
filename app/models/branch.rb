require 'geocoder'
class Branch < ActiveRecord::Base
   
  belongs_to :restaurant
  validates :street_address, :city, :presence => true
  before_save :geocode, :if => :needs_geocoding?
  attr_accessible :street_address, :city, :phone, :email, :business_hours

  private
  
  def geocode
    begin
      self.latitude, self.longitude = Geocoder.get_latlng("#{street_address}, #{city}")
    rescue Geocoder::GeocoderError => e
      logger.error e
    end
  end
  
  # lat and lng should be fetched if record is new or address is changed
  def needs_geocoding?
    self.new_record? || self.city_changed? || self.street_address_changed?
  end
    
end
 