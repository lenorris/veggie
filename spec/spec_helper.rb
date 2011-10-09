# encoding: utf-8

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Add this to load Capybara integration:
require 'capybara/rspec'
require 'capybara/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
end

def mock_google_api_response(results_size, status, lat, lng)
  results = []
  results_size.times do |n|
    result = {
       "address_components" => [
          {
            "long_name" => "29",
            "short_name" => "29",
            "types" => [ "street_number" ]
            },
          {
            "long_name" => "Annankatu",
            "short_name" => "Annankatu",
            "types" => [ "route" ]
            },
          {
            "long_name" => "Helsinki",
            "short_name" => "HKI",
            "types" => [ "locality", "political" ]
            },
          {
            "long_name" => "Uusimaa",
            "short_name" => "Uusimaa",
            "types" => [ "administrative_area_level_2", "political" ]
            },
          {
            "long_name" => "Etelä-Suomi",
            "short_name" => "Etelä-Suomi",
            "types" => [ "administrative_area_level_1", "political" ]
            },
          {
            "long_name" => "Suomi",
            "short_name" => "FI",
            "types" => [ "country", "political" ]
            },
          {
            "long_name" => "00100",
            "short_name" => "00100",
            "types" => [ "postal_code" ]
          }
          ],
          "formatted_address" => "Annankatu 29, 00100 Helsinki, Suomi",
       "geometry" => {
          "location" => {
            "lat" => lat,
            "lng" => lng
            },
            "location_type" => "ROOFTOP",
          "viewport" => {
             "northeast" => {
              "lat" => 60.16929728029150,
              "lng" => 24.93698308029150
              },
             "southwest" => {
              "lat" => 60.16659931970849,
              "lng" => 24.93428511970850
            }
          }
          },
          "types" => [ "street_address" ]
        }
      results << result
    end
  json_response = {"results" => results, "status" => status }.to_s.gsub("=>", ":")
  json_response
end

def mock_ability
  @ability = Object.new
  @ability.extend(CanCan::Ability)
  @ability.can(:manage, :all)
  @controller.stub!(:current_ability).and_return(@ability)
end
    
    
