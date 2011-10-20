class Restaurant < ActiveRecord::Base
  validates_presence_of :name, :info
  has_many :branches, :dependent => :destroy
  accepts_nested_attributes_for :branches

  def as_json(options={})
    super(:include => :branches)
  end

  before_save :add_protocol_to_website
  
  private
  
  def add_protocol_to_website
    self.website = /^http/.match(self.website) ? self.website : "http://#{self.website}"
  end
end
