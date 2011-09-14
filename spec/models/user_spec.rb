require 'spec_helper'

describe User do
  context "validations" do
    it "should save a user with a username, password and email" do
      user = FactoryGirl.build(:user)
      user.save.should be_true
    end    
    
    it "should not save a user without an username" do
      user = FactoryGirl.build(:user, :username => nil)
      user.save.should be_false
    end
    
    it "should not save a user without an email" do
      user = FactoryGirl.build(:user, :email => nil)
      user.save.should be_false
    end

    it "should not save a user without a password" do
      user = FactoryGirl.build(:user, :password => nil)
      user.save.should be_false
    end

    it "should not save a user with a invalid email address" do
      user = FactoryGirl.build(:user, :email => "userATuser.org")
      user.save.should be_false
    end
    
  end
end
