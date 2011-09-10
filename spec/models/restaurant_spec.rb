require 'spec_helper'

describe Restaurant do
  context "validations" do

    it "should not save a restaurant without a name" do
      restaurant = FactoryGirl.build(:restaurant, :name => nil)
      restaurant.save.should be_false
    end

    it "should not save a restaurant without info" do
      restaurant = FactoryGirl.build(:restaurant, :info => nil)
      restaurant.save.should be_false
    end
    
    it "should save a restaurant without website" do
      restaurant = FactoryGirl.build(:restaurant, :website => nil)
      restaurant.save.should be_true      
    end
    
  end
end
