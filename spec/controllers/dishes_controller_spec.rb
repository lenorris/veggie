require 'spec_helper'

describe DishesController do
  before(:each) do
    mock_ability
    @restaurant = FactoryGirl.create(:restaurant)
    @user = FactoryGirl.create(:user)
    @controller.stub!(:current_user).and_return(@user)
  end
  
  def valid_params
    {:dish => {:name => "Currytofu"}, :restaurant_id => @restaurant.id}
  end
  
  describe "POST create" do
    
    context "with valid params" do
      
      it "response should be success" do
        xhr :post, :create, valid_params
        response.should be_success
      end
      it "creates a new dish" do
        expect {xhr :post, :create, valid_params}.to change(@restaurant.dishes, :count).by(1)
      end
    end
    
    context "with invalid params" do
      it "if no restaurant is found it redirects to home" do
        xhr :post, :create, valid_params.merge({:restaurant_id => 6666})
        response.should redirect_to(root_path)
      end
      
      it "should respond with error if the dish has no name" do
        xhr :post, :create, valid_params.merge({:dish => {:name => nil }})
        response.status.should == 422 # :unprocessable_entity
      end
    end
  end
  
  describe "PUT update" do
    
    before(:each) do
      @dish = FactoryGirl.create(:dish)
    end
    
    context "with valid params" do
    
      it "should update the dish" do
        expect do
          xhr :put, :update, valid_params.merge({:id => @dish.id, :dish => { :name => nil}})
        end.to_not change{@dish.name}
        
        
      end
    end
    
    context "with invalid params" do
      
      it "should not change the dishes name" do
        expect do
          xhr :put, :update, valid_params.merge({:id => @dish.id, :dish => { :name => nil}})
        end.to_not change{@dish.name}
      end
      
      it "should return an invalid object" do
        xhr :put, :update, valid_params.merge({:id => @dish.id, :dish => { :name => nil}})
        assigns(:dish).errors.should_not be_empty
      end
      
      
    end
    
  end
  
end