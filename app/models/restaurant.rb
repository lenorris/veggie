class Restaurant < ActiveRecord::Base
  validates_presence_of :name, :info
  has_many :branches, :dependent => :destroy
  accepts_nested_attributes_for :branches
  has_many :comments, :dependent => :destroy
  has_many :dishes
  before_save :add_protocol_to_website

  def as_json(options={})
    super(:include => :branches)
  end
  
  private
  
  def add_protocol_to_website
    self.website = /^http/.match(self.website) ? self.website : "http://#{self.website}"
  end
end
