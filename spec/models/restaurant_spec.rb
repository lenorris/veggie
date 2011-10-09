require 'spec_helper'

describe Restaurant do
  context "validations and callbacks" do

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
    
    it "should add protol http:// to website url's that don't already have it" do
      restaurant = FactoryGirl.create(:restaurant, :website => 'tonys.fi')
      restaurant.website.should == 'http://tonys.fi'
    end
    
    it "should not modify a website url that begins with http://" do
      restaurant = FactoryGirl.create(:restaurant, :website => 'http://tonys.fi')
      restaurant.website.should == 'http://tonys.fi'
    end
    
  end
end
