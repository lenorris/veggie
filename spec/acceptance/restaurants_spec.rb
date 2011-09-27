require 'spec_helper'
 
describe 'adding a restaurant', :type => :request  do
  
  before(:each) do
    @username = 'haxxxor'
    @password = 'topsecret'
    @user = FactoryGirl.create(:user, :username => @username, :password => @password )
  end
 
it 'should create a restaurant' do
    visit '/'
    fill_in 'username', :with => @username
    fill_in 'password', :with => @password
    click_button 'Log in'
    visit '/restaurants'
    click_link 'New Restaurant'
    fill_in 'Name', :with => "Tony's bistro"
    fill_in 'Website', :with => "http://www.tonys.fi"
    fill_in 'Info', :with => 'Great italian bistro!'
    fill_in 'restaurant[branches_attributes][0][street_address]', :with => 'Annankatu 32'
    fill_in 'City', :with => 'Helsinki'
    click_button 'Create Restaurant'
    page.should have_content('Restaurant was successfully created.')
  end
end