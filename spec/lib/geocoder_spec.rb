require 'spec_helper'
require 'geocoder'

describe Geocoder do
  
  before(:each) do
    @street_address = 'Annankatu 29'
    @city = 'Helsinki' 
    @country = 'fi'
    @expected_lat = 60.16794829999999
    @expected_lng = 24.93563410
    @expected_coordinates = [@expected_lng, @expected_lng]
    Rails.env.stub(:test?).and_return(false)
    @google_adapter = double('google adapter')
    @yahoo_adapter = double('yahoo adapter')
    Geocoder.stub(:adapters).and_return([@google_adapter, @yahoo_adapter])
    @geocode = lambda { Geocoder.get_latlng(@street_address, @city, @country) }
  end



  context "first geocoding adapter fails" do
    before(:each) do
      @google_adapter.stub(:geocode).and_raise(Geocoder::GeocoderError)
    end
    it "should call the remaining adapters" do
      @yahoo_adapter.should_receive(:geocode)
      @geocode.call
    end
    it "should return what the next succeeding adapter returns" do
      @yahoo_adapter.stub(:geocode).and_return(@expected_coordinates)
      expect(@geocode.call).to eq @expected_coordinates
    end
  end

  context "first geocoding adapter succeeds" do
    before(:each) do
      @google_adapter.stub(:geocode).with(@street_address, @city, @country).and_return(@expected_coordinates)
    end

    it "should return the value returned by the adapter" do
      expect(@geocode.call).to eq @expected_coordinates
    end

    it "should try to geocode only first when it succeeds" do
      @yahoo_adapter.should_not_receive(:geocode)
      @geocode.call
    end
  end

  context "all adapters fail" do
    it "should raise a GeocoderError" do
      @google_adapter.stub(:geocode).and_raise(Geocoder::GeocoderError)
      @yahoo_adapter.stub(:geocode).and_raise(Geocoder::GeocoderError)
      expect(@geocode).to raise_error(Geocoder::GeocoderError)
    end
  end

  context "mock responses" do
    it "should return Bamboo Centers coordinates when rails environment is test" do
      Rails.env.stub!(:test?).and_return(true) # stubbed because we stub it as false for all tests earlier
      Geocoder.get_latlng('Trolololo', 'what', 'ever').should eq [@expected_lat, @expected_lng]
    end   
    
  end
  
end