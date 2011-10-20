# encoding: utf-8
require 'spec_helper'

describe "restaurants/show.html.haml" do
  before(:each) do
=begin
    @restaurant = assign(:restaurant, stub_model(Restaurant,
      :name => "Tony's",
      :website => "http://www.ristorantetony.fi",
      :info => "Excellent Italian bistro!"
    ))
=end    
    @restaurant = Restaurant.new(:name => "New Bamboo Center", :website => "http://www.newbamboocenter.com/", :info => "New Bamboo Center on vuonna 1997 perustettu kiinalainen ravintola. Kiinalaisten ruokien lisäksi ravintolassamme tarjoillaan malesialaisia curryruokia. Pyrimme käyttämään tuoreita raaka-aineita, muutamaa Suomesta vaikeasti saatavissa olevaa erikoisuutta lukuunottamatta.")
    bamboobr = Branch.create(:street_address => "Annankatu 29", :city => "Helsinki", :phone => "+358 9 694 3117", :business_hours => "ma-pe 11-22, la 12-22, su 12-22", :email => "newbamboocenter@gmail.com")
    @restaurant.branches << bamboobr
    @restaurant.save

  end

  it "displays restaurant's attributes" do
    render
    rendered.should have_content(@restaurant.name)
    rendered.should have_content(@restaurant.website)
    rendered.should have_content(@restaurant.info)    
  end
  
  it "has a map div" do 
    render
    rendered.should have_selector('#map_canvas')
  end
  
end
