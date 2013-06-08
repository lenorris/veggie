require 'spec_helper'
require 'http_client'

describe HttpClient do

  before(:all) do
    @base_url = "http://maps.googleapis.com/maps/api/geocode/json"
    @parameters = {:address => 'Annankatu 29, Helsinki', :region => 'Finland', :sensor => 'false'}
    @client = HttpClient.new
  
  end

	context "#get" do
		it "calls RestClient.get to do the actual request" do
			RestClient.should_receive(:get)
			@client.get @base_url, @parameters
		end

		it "passes parameters to RestClient" do
			RestClient.should_receive(:get).with(@base_url, :params => @parameters)
			@client.get @base_url, @parameters
		end

		it "passes an empty hash if no http parameters given" do
			RestClient.should_receive(:get).with(@base_url, :params => {})
			@client.get @base_url
		end

		it "returns whatever Net:HTTP.get returns" do
			RestClient.stub(:get).and_return("trololo")
			expect(@client.get(@base_url)).to eq "trololo"
		end
	end
end
