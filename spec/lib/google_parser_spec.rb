require 'spec_helper'
require 'google_parser'

describe Geocoder::GoogleParser do

  before(:each) do
    @parser = Geocoder::GoogleParser.new
    @responses = {:ok => "OK", :empty => "ZERO_RESULTS", :over_limit => "OVER_QUERY_LIMIT", :denied => "REQUEST_DENIED", :invalid => "INVALID_REQUEST"}
  end

  context "response is ok" do
    before(:each) do
   	  @expected_lat, @expected_lng = 60.16783980, 24.93578350
      response = mock_google_api_response(1, @responses[:ok], @expected_lat, @expected_lng)
      @lat, @lng = @parser.parse(response)
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
      @lat, @lng = 60, 70
      @response = nil
      @parse = lambda {@parser.parse(@response)}
    end
    
    it 'throws an GeocodingException with invalid json' do
      @response = "trololoo"
      expect(@parse).to raise_error(Geocoder::GeocoderError)
    end

    it 'throws an exception with empty results' do
      @response = mock_google_api_response(0, @responses[:empty], @lat, @lng)
      expect(@parse).to raise_error(Geocoder::EmptyResultsError)
    end

    it 'raises an exception with ambiguous results' do
      @response = mock_google_api_response(2, @responses[:ok], @lat, @lng)
      expect(@parse).to raise_error(Geocoder:: AddressAmbiguousError)
    end
    
    it "should raise an Error if the query limit to google api is exceeded" do
      @response = mock_google_api_response(0, @responses[:over_limit], @lat, @lng)
      expect(@parse).to raise_error(Geocoder::OverQueryLimitError)
    end
        
    it "should raise an Error if the response is request denied" do
      @response = mock_google_api_response(0, @responses[:denied], @lat, @lng)
      expect(@parse).to raise_error(Geocoder::RequestDeniedError)
    end    
    
      
    it "should raise an Error if the response is invalid request" do
      @response = mock_google_api_response(0, @responses[:invalid], @lat, @lng)
      expect(@parse).to raise_error(Geocoder::InvalidRequestError)
    end

    it "should raise geocoding exception when it receives an unknown status" do
      @response = mock_google_api_response(0, "trololoo", @lat, @lng)
      expect(@parse).to raise_error(Geocoder::GeocoderError)
    end
  end

end