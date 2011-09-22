# encoding: utf-8
require 'spec_helper'
require 'geocoder'

describe Branch do
  
  context "validations" do

    it "should not save a branch without a street address" do
      branch = FactoryGirl.build(:branch, :street_address => nil)
      branch.save.should be_false
    end

    it "should not save a branch without a city" do
      branch = FactoryGirl.build(:branch, :city => nil)
      branch.save.should be_false
    end
    
  end
  
  
  context "mass assigning attributes" do
    
    before(:each) do
      @branch = FactoryGirl.create(:branch)
    end
    
    it "should not allow to change id" do
      expect { @branch.update_attributes({:id => 666}) }.to_not change { @branch.id }
    end
    
    it "should not allow to change restaurant id" do
      expect { @branch.update_attributes({:restaurant_id => 666}) }.to_not change { @branch.restaurant_id }
    end
    
    it "should not allow to change latitude" do
      expect { @branch.update_attributes({:latitude => 666}) }.to_not change { @branch.latitude }
    end
    
    it "should not allow to change latitude" do
      expect { @branch.update_attributes({:longitude => 666}) }.to_not change { @branch.longitude }
    end
  end
  
  describe "geocoding" do
    
    before (:all) do
      @lat = 60.16794829999999
      @lng = 24.93563410
    end
    
    context "on create" do     
     it "should try to geocode branches address on create" do
        Geocoder.should_receive(:get_latlng).with("Annankatu 29, Helsinki").and_return([@lat, @lng])
        branch = FactoryGirl.create(:branch, :city => 'Helsinki', :street_address => 'Annankatu 29')
        branch.latitude.should == @lat
        branch.longitude.should == @lng    
      end
      
      it "should log error if geocoding fails" do
        Geocoder.should_receive(:get_latlng).and_raise(Geocoder::RequestDeniedError)
        Rails.logger.should_receive(:error)
        branch = FactoryGirl.create(:branch, :city => 'Helsinki', :street_address => 'Annankatu 29')
      end
        
    end
    
    context "on update" do
      
      before(:each) do
        @branch = FactoryGirl.create(:branch, :street_address => 'Annankatu 29', :city => 'Helsinki')  
      end
      
      it "should try to geocode branch address on update if street address was changed" do
        Geocoder.should_receive(:get_latlng).with("Change Street 123, Helsinki").and_return([@lat, @lng])
        @branch.update_attributes :street_address => "Change Street 123"
        @branch.latitude.should == @lat
        @branch.longitude.should == @lng
      end
      
      it "should try to geocode branch address on update if city was changed" do
        Geocoder.should_receive(:get_latlng).with("Annankatu 29, Espoo").and_return([@lat, @lng])
        @branch.update_attributes :city => "Espoo"
        @branch.latitude.should == @lat
        @branch.longitude.should == @lng
      end
            
      it "should not try to geocode branch address if address wasn't changed" do
        Geocoder.should_not_receive(:get_latlng)
        @branch.update_attributes :phone => "0700-666666"
      end
    end
  end

  
end
