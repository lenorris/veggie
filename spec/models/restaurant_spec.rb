require 'spec_helper'

describe Restaurant do
  context "validations" do
    
    before(:each) do
      @valid_params = {:name => "Tony's deli", :info => "Excellent italian", :website => "http://www.tonys.com"}
      @restaurant = Restaurant.new(@valid_params)
    end
     
    it "should not save a restaurant without a name" do
      @restaurant.name = nil
      @restaurant.save.should be_false
    end
    it "should not save a restaurant without info" do
      @restaurant.info = nil
      @restaurant.save.should be_false
    end
    it "should save a restaurant without website" do
      @restaurant.website = nil
      @restaurant.save.should be_true      
    end
  end
end
