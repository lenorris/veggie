require 'spec_helper'
require 'google_geocoder'

describe Geocoder::GoogleGeocoder do
  
  before(:all) do
    @base_uri = "https://maps.googleapis.com/maps/api/geocode/json?"
    @street_address = 'Annankatu 29'
    @city = 'Helsinki' 
    @country = 'fi'
    @postal_code = '00250'
    @responses = {:ok => "OK", :empty => "ZERO_RESULTS", :over_limit => "OVER_QUERY_LIMIT", :denied => "REQUEST_DENIED", :invalid => "INVALID_REQUEST"}
    @geocoder = Geocoder::GoogleGeocoder.new
    @expected_lat, @expected_lng = 60.16783980, 24.93578350
    
  end
  
  context "url" do
    it "is built correctly" do
      uri_encoded_address = URI.encode("Annankatu 29,Helsinki")
      Net::HTTP.should_receive(:get).with(@base_uri + "address=#{uri_encoded_address}&region=#{URI.encode(@country)}&sensor=false").and_return(mock_google_api_response(1, @responses[:ok], @expected_lat, @expected_lng))
      @geocoder.geocode(@street_address, @city, @country, @postal_code)
    end
  end
    
  context "response is ok" do
    before(:each) do
      Net::HTTP.stub(:get).and_return(mock_google_api_response(1, @responses[:ok], @expected_lat, @expected_lng))
      @lat, @lng = @geocoder.geocode(@street_address, @city, @country, @postal_code)
    end
    
    it "returns correct lat" do
      expect(@lat).to be_within(0.01).of(@expected_lat)
    end
    
    it "returns correct lng" do
      expect(@lng).to be_within(0.01).of(@expected_lng)
    end
  end
  
  context "response is not ok" do
    before(:each) do
      @geocode = lambda { @geocoder.geocode(@street_address, @city, @country, @postal_code) }
    end
    
    context "invalid JSON" do
      before(:each) do
        Net::HTTP.stub(:get).and_return('trololoo')
      end
      it 'throws an GeocodingException' do
        expect(@geocode).to raise_error(Geocoder::GeocoderError)
      end
    end
  end
  
end