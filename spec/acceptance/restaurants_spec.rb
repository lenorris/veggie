require 'spec_helper'
require 'acceptance_spec_helper'
 
describe 'adding a restaurant', :type => :request  do
  
  before(:each) do
    @username = 'haxxxor'
    @password = 'topsecret'
    @user = FactoryGirl.create(:user, :username => @username, :password => @password )
  end
 
it 'should create a restaurant' do
    login(@username, @password)
    visit '/restaurants'
    click_link 'New Restaurant'
    fill_in 'restaurant_name', :with => "Tony's bistro"
    fill_in 'restaurant_website', :with => "http://www.tonys.fi"
    fill_in 'restaurant_info', :with => 'Great italian bistro!'
    fill_in 'restaurant[branches_attributes][0][street_address]', :with => 'Annankatu 32'
    fill_in 'restaurant[branches_attributes][0][city]', :with => 'Helsinki'
    click_button 'Luo ravintola'
    page.should have_content(I18n.t('succesfully_created'))
  end
end