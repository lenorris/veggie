class Branch < ActiveRecord::Base
  belongs_to :restaurant
  validates :street_address, :city, :presence => true
end
 