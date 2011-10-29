class Dish < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  
  validates :name, :presence => true, :uniqueness => { :scope => :restaurant_id, :case_sensitive => false }
  validates :restaurant, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0}, :allow_nil => true
  
  attr_accessible :name, :description, :price
end
