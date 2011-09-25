require 'spec_helper'
require "cancan/matchers"


describe Ability do
  
  context "logged in users" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @ability = Ability.new(@user)
    end

    it "should be able to create, read and update a restaurant" do
      @ability.should be_able_to([:create, :update, :read], [Restaurant.new, Branch.new])
    end
    
    it "should not be able to delete a restaurant or a branch" do
      @ability.should_not be_able_to(:destroy, [Restaurant.new, Branch.new])
    end
    
  end
  
  context "guests" do
    before(:each) do
      @ability = Ability.new(nil)
    end
    
    it "should be able to create a user account" do
      @ability.should be_able_to(:create, User.new)
    end
    
    it "should be able to read restaurants and branches" do
      @ability.should be_able_to(:read, [Restaurant.new, Branch.new])
    end
    
    it "should not be able to create, update, or destroy restaurants" do
      @ability.should_not be_able_to([:create, :update, :destroy], Restaurant.new)
    end
    
    it "should not be able to create, update or destroy branches" do
      @ability.should_not be_able_to([:create, :update, :destroy], Branch.new)
    end
  end
  
end
