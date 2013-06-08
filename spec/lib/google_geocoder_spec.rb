require 'spec_helper'
require 'google_geocoder'

describe Geocoder::GoogleGeocoder do

  # https://developers.google.com/maps/documentation/geocoding/
  before(:each) do
    @street_address = 'Annankatu 29'
    @city = 'Helsinki' 
    @country = 'fi'
    @geocoder = Geocoder::GoogleGeocoder.new
    @geocode = lambda { @geocoder.geocode(@street_address, @city, @country) }

    @responses = {:ok => "OK", :empty => "ZERO_RESULTS", :over_limit => "OVER_QUERY_LIMIT", :denied => "REQUEST_DENIED", :invalid => "INVALID_REQUEST"}

    @http_client = mock("http_client")
    @parser = mock('google_parser')
    @parser.stub(:parse)
    HttpClient.stub(:new).and_return @http_client
    Geocoder::GoogleParser.stub(:new).and_return @parser
  end
  
  context "http client" do
    it "is called with correct parameters" do
      @base_url = "http://maps.googleapis.com/maps/api/geocode/json"
      parameters = {:address => "#{@street_address},#{@city}", :region => @country, :sensor => false} 
      @http_client.should_receive(:get).with(@base_url, parameters).and_return(mock_google_api_response(1, @responses[:ok], @expected_lat, @expected_lng))
      @geocode.call
    end
  end

  context "parser" do

    before(:each) do
      @response = mock_google_api_response(1, @responses[:ok], @expected_lat, @expected_lng)
      @http_client.stub(:get).and_return(@response)
    end

    it "calls it with the response from http client" do
      @parser.should_receive(:parse).with(@response)
      @geocode.call
    end

    context "parser returns lat and lng" do
      before(:each) do
        @expected_lat, @expected_lng = 60.16783980, 24.93578350
        @parser.stub(:parse).and_return([@expected_lat, @expected_lng])
        @http_client.stub(:get).and_return(mock_google_api_response(1, @responses[:ok], @expected_lat, @expected_lng))
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
      before(:each) do
        @exception = Geocoder::GeocoderError.new
        @parser.stub(:parse).and_raise(@exception)
      end

      it 'propagates the exception' do
        expect(@geocode).to raise_error(@exception)
      end
    end

  end

end