require 'spec_helper'

describe Comment do
  
  before(:each) do
    @comment = FactoryGirl.create(:comment)
    @user = @comment.user
    @restaurant = @comment.restaurant
    @body = 'Trolololo'
  end
  
  it "should not allow mass assigning of user" do
    expect { @comment.update_attributes(:user_id => '666') }.to_not change { @comment.user_id }
  end
  
  it "should not allow mass assigning of user" do
    expect { @comment.update_attributes(:restaurant_id => '666') }.to_not change { @comment.user_id }
  end
  
  it "should validate that a comment belongs to a restaurant" do
    comment = Comment.new(:body => @body)
    comment.user = @user
    comment.save.should be_false
  end
  
  it "should validate that a comment belongs to a user" do
    comment = Comment.new(:body => @body)
    comment.restaurant = @restaurant
    comment.save.should be_false
  end
  
  it "should validate that a comment can't be empty" do
    comment = Comment.new
    comment.user = @user
    comment.restaurant = @restaurant
    comment.save.should be_false
  end
  
  it "should be able to create a comment with all values" do
    comment = Comment.new(:body => @body)
    comment.restaurant = @restaurant
    comment.user = @user
    comment.save.should be_true
  end
end
