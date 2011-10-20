require 'spec_helper'
require 'acceptance_spec_helper'
 
describe 'comments', :type => :request  do
  
  before(:each) do
    @user = FactoryGirl.create(:user, :username => 'haxxxxxor', :password => 't0ps3cR3tZZZ' )
    @restaurant = FactoryGirl.create(:branch).restaurant
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
  
  it 'should show errors and not create a comment if body is empty', :js => true do
    login(@user)
    visit restaurant_path(@restaurant)
    comment_count =  page.all("#comments .comment").size
    click_button I18n.t('helpers.submit.comment.create')
    page.all("#comments .comment").size.should == comment_count
    page.find('#error_explanation').should have_content(I18n.t('errors.messages.blank'))
    Comment.count.should == 0
  end
  
  it "should instruct the user to login if she is a guest", :js => true do
    visit restaurant_path(@restaurant)
    fill_in "comment_body", :with => @comment_body
    page.find('#error_explanation').should have_content(I18n.t('comments.login'))
  end
  
end