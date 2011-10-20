class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  
  delegate :username, :to => :user
  
  validates_presence_of :user, :restaurant, :body
  
  attr_accessible :body
end
