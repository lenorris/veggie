require 'spec_helper'
 
describe 'adding a restaurant', :type => :request  do
 
it 'should create a restaurant' do
    visit '/restaurants'
    click_link 'New Restaurant'
    fill_in 'Name', :with => "Tony's bistro"
    fill_in 'Website', :with => "http://www.tonys.fi"
    fill_in 'Info', :with => 'Great italian bistro!'
    click_button 'Create Restaurant'
    page.should have_content('Restaurant was successfully created.')
  end
end