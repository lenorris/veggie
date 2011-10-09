require 'spec_helper'
require 'acceptance_spec_helper'
 
describe 'comments', :type => :request  do
  
  before(:all) do
    @user = FactoryGirl.create(:user, :username => 'haxxxxxor', :password => 't0ps3cR3tZZZ' )
    @restaurant = FactoryGirl.create(:restaurant)
    @comment_body = "Had currytofu and it was the best meal ever. My friend had sataytofu and it was awesome too. I will definitely visit again!"
  end
 
  it 'should create a comment and show it and a thanks for commenting -note', :js => true do
    login(@user)
    visit restaurant_path(@restaurant)
    fill_in "comment_body", :with => @comment_body
    comment_count =  page.all("#comments .comment").size
    click_button I18n.t('helpers.submit.comment.create')
    sleep 1 #TODO: find a better fix for this
    page.all("#comments .comment").size.should == comment_count + 1
    page.all('#comments .comment').last.should have_content(@comment_body)
    page.find('#notice').should have_content(I18n.t('comments.thanks'))
    page.should have_xpath("//form[@id='new_comment' and @style='display: none;']") # should hide the form
  end
  
  
end