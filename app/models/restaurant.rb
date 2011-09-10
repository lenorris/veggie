class Restaurant < ActiveRecord::Base
  validates_presence_of :name, :info
  
end
