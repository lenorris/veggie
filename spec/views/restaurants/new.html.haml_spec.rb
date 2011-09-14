require 'spec_helper'

describe "restaurants/new.html.haml" do
  before(:each) do
    restaurant = stub_model(Restaurant,
      :name => "MyString",
      :website => "MyString",
      :info => "MyText"
    ).as_new_record
    branch = stub_model(Branch, 
      :street_address => "MyString",
      :city => "MyString",
      :email => "MyString",
      :phone => "MyString",
      :business_hours => "MyString"
    ).as_new_record
    restaurant.branches = [branch]
    assign(:restaurant, restaurant) 
  end


  it "renders new restaurant form" do
    render
    
    rendered.should have_selector('form#new_restaurant')
    rendered.should have_field('Name')
    rendered.should have_field('Website')
    rendered.should have_field('Info')
    rendered.should have_field("restaurant_branches_attributes_0_street_address")
    rendered.should have_field('City')
    rendered.should have_field('restaurant_branches_attributes_0_business_hours')
    rendered.should have_field('Phone')
    rendered.should have_field('Email')
    
  end
end
