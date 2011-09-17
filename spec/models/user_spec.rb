require 'spec_helper'

describe User do
  context "validations on create" do
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
  
  context "mass assigning attributes" do
    
    before(:each) do
      @user = FactoryGirl.create(:user)
    end
    
    it "should not allow mass assign of a new id" do
      expect { @user.update_attributes({:id => 666}) }.to_not change { @user.id }
    end
    
    it "should not allow mass assign of timestamps" do
      expect { @user.update_attributes({:created_at => Time.now}) }.to_not change { @user.created_at }
    end
  end
end
