class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :username
  has_secure_password
  validates_presence_of :password, :on => :create
  validates_presence_of :username
  validates_presence_of :email  
  validates :email,   
            :presence => true,   
            :uniqueness => true,   
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
              
  include Rails.application.routes.url_helpers
end
