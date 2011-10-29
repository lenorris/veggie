require 'spec_helper'

describe Dish do

  context "validations" do
    
    it "should not save a dish without name" do
      dish = FactoryGirl.build(:dish, :name => nil)
      dish.save.should be_false
    end
    
    it "should not save a dish that doesn't belong to a restaurant" do
      dish = FactoryGirl.build(:dish, :restaurant => nil)
      dish.save.should be_false
    end
    
    it "should not save two dishes with same name in one restaurant" do
      name = "Satay tofu"
      dish = FactoryGirl.create(:dish, :name => name)
      new_dish = FactoryGirl.build(:dish, :name => name, :restaurant => dish.restaurant)
      new_dish.save.should be_false
    end
    
    it "should allow to create two same named dishes if they are in different restaurants" do
      dish = FactoryGirl.create(:dish)
      new_dish = FactoryGirl.build(:dish, :name => dish.name)
      new_dish.save.should be_true
    end
    
    it "should not save a dish which price is not numerical" do
      dish = FactoryGirl.build(:dish, :price => "100 euros")
      dish.save.should be_false
    end
    
    it "should not save a dish with a negative price" do
      dish = FactoryGirl.build(:dish, :price => "-10")
      dish.save.should be_false
    end
    
    it "should save a valid dish" do
      dish = FactoryGirl.build(:dish)
      dish.save.should be_true
    end
  end
  
  context "mass assigning attributes" do
    
    before(:each) do
      @dish = FactoryGirl.create(:dish)
    end
    
    it "should not allow to update id" do
      expect { @dish.update_attributes({:id => 666}) }.to_not change { @dish.id }
    end
    
    it "should not allow to update the user who added the dish" do
      expect { @dish.update_attributes({:user_id => 666}) }.to_not change { @dish.user_id }
    end
    
    it "should not allow to update restaurant" do
      expect { @dish.update_attributes({:restaurant_id => 666}) }.to_not change { @dish.restaurant_id }
    end
    
  end
  
  
end