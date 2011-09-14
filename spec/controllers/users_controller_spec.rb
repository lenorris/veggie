require 'spec_helper'

describe UsersController do
  def valid_attributes
    {:username => "Quinn", :password => "IQ260", :email => "dr.quinn@sealab.com"}
  end
  
  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      assigns(:user).should be_a_new(User)
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, :user => valid_attributes
        }.to change(User, :count).by(1)
      end
    end
  end
  
end
