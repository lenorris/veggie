require 'spec_helper'
require 'acceptance_spec_helper'
 
describe 'comments', :type => :request  do
    
  before(:each) do
    @user = FactoryGirl.create(:user, :username => 'haxxxxxor', :password => 't0ps3cR3tZZZ' )
    @restaurant = FactoryGirl.create(:branch).restaurant
    @comment_body = "Had currytofu and it was the best meal ever. My friend had sataytofu and it was awesome too. I will definitely visit again!"
    login(@user)
    visit restaurant_path(@restaurant)
  end
  
  
  context 'valid comment' do
    before(:each) do
      fill_in "comment_body", :with => @comment_body
    end
    
    it 'should create a comment' do
      expect{ click_comment_button }.to change(Comment, :count).by(1)
    end
    
    context 'after creation' do
      before(:each) do
        click_comment_button
      end
      
      it 'should show the new comment', :js => true do
        expect(all('.comment').last).to have_content(@comment_body)
      end
      
      it 'should snow a thanks for commenting -note', :js => true do
        expect(page.find('#notice')).to have_content(I18n.t('comments.thanks'))
      end
      
      it 'should not show the comment form', :js => true do
        expect(page).to have_no_selector('#new_comment')
      end
      
    end
  end
  
  context 'invalid comment' do
    before(:each) do
      click_button I18n.t('helpers.submit.comment.create')
    end
    
    it 'should not show a new comment', :js => true do
      expect(page.all("#comments .comment").size).to eq 0
    end
    
    it 'should show an error message', :js => true do
      expect(page.find('#error_explanation')).to have_content(I18n.t('errors.messages.blank'))
    end
    
    it 'should show errors and not create a comment if body is empty', :js => true do
      expect(Comment.count).to eq 0
    end
  end
  
  
  private
    def click_comment_button
      click_button I18n.t('helpers.submit.comment.create')
      sleep 1 #TODO find a better way
    end
end