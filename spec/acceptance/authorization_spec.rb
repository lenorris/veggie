require 'spec_helper'
 
describe 'authorization', :type => :request  do
  
  it "should redirect to root page if user doesn't have the correct rights" do
    visit restaurants_path
    click_link 'New Restaurant'
    current_path.should == root_path
    #page.should have_selector('#alert') 
    page.should have_selector('#placeholder') # For placeholder index! Use above upon release
  end
  
end