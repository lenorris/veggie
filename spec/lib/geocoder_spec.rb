require 'spec_helper'
require 'geocoder'

describe Geocoder do
  
  before(:all) do
    @address = 'Annankatu 29, Helsinki, Finland'
    @lat = 60.16794829999999
    @lng = 24.93563410
    @responses = {:ok => "OK", :empty => "ZERO_RESULTS", :over_limit => "OVER_QUERY_LIMIT", :denied => "REQUEST_DENIED", :invalid => "INVALID_REQUEST"}
  end
  
  before(:each) do
    # normally during tests geocoding is stopped at the beginning and mock answer returned
    # to circumvent that we stub Rails.env
    Rails.env.stub(:test?).and_return(false)
  end
  
  context "with a ok response" do

    it "should parse the result and return lat and lng if results are unambiguous" do
      Net::HTTP.should_receive(:get).and_return(mock_google_api_response(1, @responses[:ok], @lat, @lng))
      lat, lng = Geocoder.get_latlng(@address)
      lat.should be_within(0.01).of(@lat)
      lng.should be_within(0.01).of(@lng)
    end
    
    it "should raise an Error if the results are ambiguous" do
      Net::HTTP.should_receive(:get).and_return(mock_google_api_response(2, @responses[:ok], @lat, @lng))
      lambda {Geocoder.get_latlng(@address)}.should raise_error(Geocoder::AddressAmbiguousError)
    end
  
  end
  
  context "with a zero results response" do
    
    it "should raise an Error if the results are empty" do
      Net::HTTP.should_receive(:get).and_return(mock_google_api_response(0, @responses[:empty], @lat, @lng))
      lambda {Geocoder.get_latlng(@address)}.should raise_error(Geocoder::EmptyResultsError)
    end
    
  end
  
  context "with over query limit response" do
    
    it "should raise an Error if the query limit to google api is exceeded" do
      Net::HTTP.should_receive(:get).and_return(mock_google_api_response(0, @responses[:over_limit], @lat, @lng))
      lambda {Geocoder.get_latlng(@address)}.should raise_error(Geocoder::OverQueryLimitError)
    end
    
  end
  
  context "with a request denied response" do
    
    it "should raise an Error if the response is request denied" do
      Net::HTTP.should_receive(:get).and_return(mock_google_api_response(0, @responses[:denied], @lat, @lng))
      lambda {Geocoder.get_latlng(@address)}.should raise_error(Geocoder::RequestDeniedError)
    end    
    
  end
  
  context "with a invalid request response" do
    
    it "should raise an Error if the response is invalid request" do
      Net::HTTP.should_receive(:get).and_return(mock_google_api_response(0, @responses[:invalid], @lat, @lng))
      lambda {Geocoder.get_latlng(@address)}.should raise_error(Geocoder::InvalidRequestError)
    end  
  
  end
  
  context "mock responses" do
    before (:all) do
      @lat = 60.16794829999999
      @lng = 24.93563410
    end
    
    it "should return Bamboo Centers coordinates when rails environment is test" do
      Rails.env.stub!(:test?).and_return(true) # stubbed because we stub it as false for all tests earlier
      Geocoder.get_latlng('Trolololo').should == [@lat, @lng]
    end   
    
  end
  
end