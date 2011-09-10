class Branch < ActiveRecord::Base
  belongs_to :restaurant
  validates :restaurant, :street_address, :city, :presence => true
end
 