require 'spec_helper'

describe "restaurants/show.html.erb" do
  before(:each) do
    @restaurant = assign(:restaurant, stub_model(Restaurant,
      :name => "Tony's",
      :website => "http://www.ristorantetony.fi",
      :info => "Excellent Italian bistro!"
    ))
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
