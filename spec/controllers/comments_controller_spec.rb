require 'spec_helper'

describe CommentsController do
  before(:each) do
    mock_ability
    @restaurant = FactoryGirl.create(:restaurant)
    @user = FactoryGirl.create(:user)
    @controller.stub!(:current_user).and_return(@user)
  end
  
  def valid_params
    {:comment => {:body => "Trolololo."}, :restaurant_id => @restaurant.id}
  end
  
  describe "POST create" do
    
    context "with valid params" do
      it "creates a new comment" do
        expect {xhr :post, :create, valid_params}.to change(Comment, :count).by(1)
      end
    end
    
    context "with invalid params" do
      it "if no restaurant is found it redirects to home" do
        xhr :post, :create, valid_params.merge({:restaurant_id => 6666})
        response.should redirect_to(root_path)
      end
    end
    
  end
end
