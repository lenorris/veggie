require 'spec_helper'
require "cancan/matchers"


describe Ability do
  
  describe "logged in users" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
      @ability = Ability.new(@user)
    end
    
    context "restaurants" do
      it "should be able to create a restaurant" do
        @ability.should be_able_to(:create, Restaurant.new)
      end
      
      it "should be able to read a restaurant" do
        @ability.should be_able_to(:read, Restaurant.new)
      end
  
      it "should be able to update a restaurant" do
        @ability.should be_able_to(:update, Restaurant.new)
      end
      
      it "should not be able to destroy a restaurant" do
        @ability.should_not be_able_to(:destroy, Restaurant.new)
      end
    end
    
    context "branches" do
      it "should be able to create a branch" do
        @ability.should be_able_to(:create, Branch.new)
      end
      
      it "should be able to read a branch" do
        @ability.should be_able_to(:read, Branch.new)
      end
  
      it "should be able to update a branch" do
        @ability.should be_able_to(:update, Branch.new)
      end
      
      it "should not be able to destroy a branch" do
        @ability.should_not be_able_to(:destroy, Branch.new)
      end
    end
    
    context "user accounts" do
      it "should not be able to create a user account" do
        @ability.should_not be_able_to(:create, User.new)
      end
    end
    
  end
  
  describe "guests" do
    before(:each) do
      @ability = Ability.new(nil)
    end
    
    context "user accounts" do
      it "should be able to create a user account" do
        @ability.should be_able_to(:create, User.new)
      end
    end
    
    context "restaurants" do
      it "should be able to read restaurant" do
        @ability.should be_able_to(:read, Restaurant.new)
      end
      it "should not be able to create restaurant" do
        @ability.should_not be_able_to(:create, Restaurant.new)
      end
      it "should not be able to update restaurant" do
        @ability.should_not be_able_to(:update, Restaurant.new)
      end
      it "should not be able to destroy restaurant" do
        @ability.should_not be_able_to(:destroy, Restaurant.new)
      end
    end
    
    context "branches" do
      it "should be able to read branch" do
        @ability.should be_able_to(:read, Branch.new)
      end
      it "should not be able to create branch" do
        @ability.should_not be_able_to(:create, Branch.new)
      end
      it "should not be able to update branch" do
        @ability.should_not be_able_to(:update, Branch.new)
      end
      it "should not be able to destroy branch" do
        @ability.should_not be_able_to(:destroy, Branch.new)
      end
    end
     
  end
  
end
