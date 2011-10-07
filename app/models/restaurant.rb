class Restaurant < ActiveRecord::Base
  validates_presence_of :name, :info
  has_many :branches, :dependent => :destroy
  accepts_nested_attributes_for :branches
  has_many :comments, :dependent => :destroy
  
end
