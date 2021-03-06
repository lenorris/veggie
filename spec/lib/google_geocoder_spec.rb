require 'spec_helper'
require 'google_geocoder'

describe Geocoder::GoogleGeocoder do

  # https://developers.google.com/maps/documentation/geocoding/
  before(:all) do
    @base_uri = "http://maps.googleapis.com/maps/api/geocode/json?"
    @street_address = 'Annankatu 29'
    @city = 'Helsinki' 
    @country = 'fi'
    @responses = {:ok => "OK", :empty => "ZERO_RESULTS", :over_limit => "OVER_QUERY_LIMIT", :denied => "REQUEST_DENIED", :invalid => "INVALID_REQUEST"}
    @geocoder = Geocoder::GoogleGeocoder.new
    @expected_lat, @expected_lng = 60.16783980, 24.93578350
    @geocode = lambda { @geocoder.geocode(@street_address, @city, @country) }
    
  end
  
  context "url" do
    it "is built correctly" do
      uri_encoded_address = URI.encode("Annankatu 29,Helsinki")
      expected_uri = URI.parse(@base_uri + "address=#{uri_encoded_address}&region=#{URI.encode(@country)}&sensor=false")
      Net::HTTP.should_receive(:get).with(expected_uri).and_return(mock_google_api_response(1, @responses[:ok], @expected_lat, @expected_lng))
      @geocode.call
    end
  end
    
  context "response is ok" do
    before(:each) do
      Net::HTTP.stub(:get).and_return(mock_google_api_response(1, @responses[:ok], @expected_lat, @expected_lng))
      @lat, @lng = @geocode.call
    end
    
    it "returns correct lat" do
      expect(@lat).to be_within(0.01).of(@expected_lat)
    end
    
    it "returns correct lng" do
      expect(@lng).to be_within(0.01).of(@expected_lng)
    end
  end
  
  context "response is not ok" do
    
    it 'throws an GeocodingException with invalid json' do
      Net::HTTP.stub(:get).and_return('trololoo')
      expect(@geocode).to raise_error(Geocoder::GeocoderError)
    end

    it 'throws an exception with empty results' do
      Net::HTTP.stub(:get).and_return(mock_google_api_response(0, @responses[:empty], @lat, @lng))
      expect(@geocode).to raise_error(Geocoder::EmptyResultsError)
    end

    it 'raises an exception with ambiguous results' do
      Net::HTTP.stub(:get).and_return(mock_google_api_response(2, @responses[:ok], @lat, @lng))
    end
    
    it "should raise an Error if the query limit to google api is exceeded" do
      Net::HTTP.stub(:get).and_return(mock_google_api_response(0, @responses[:over_limit], @lat, @lng))
      expect(@geocode).to raise_error(Geocoder::OverQueryLimitError)
    end
        
    it "should raise an Error if the response is request denied" do
      Net::HTTP.stub(:get).and_return(mock_google_api_response(0, @responses[:denied], @lat, @lng))
      expect(@geocode).to raise_error(Geocoder::RequestDeniedError)
    end    
    
      
    it "should raise an Error if the response is invalid request" do
      Net::HTTP.stub(:get).and_return(mock_google_api_response(0, @responses[:invalid], @lat, @lng))
      expect(@geocode).to raise_error(Geocoder::InvalidRequestError)
    end

    it "should raise geocoding exception when it receives an unknown status" do
      Net::HTTP.stub(:get).and_return(mock_google_api_response(0, "trololoo", @lat, @lng))
      expect(@geocode).to raise_error(Geocoder::GeocoderError)
    end
  end
  
end