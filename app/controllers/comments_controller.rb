class CommentsController < ApplicationController
  respond_to :html, :js
  before_filter :find_restaurant
  
  def create
    @comment = Comment.new(params[:comment])
    authorize! :create, @comment
    @comment.user = current_user
    @comment.restaurant = @restaurant
    @comment.save
    respond_with @comment
  end
  
  private
  
  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
  
end
