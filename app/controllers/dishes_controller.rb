class DishesController < ApplicationController
  respond_to :js
  before_filter :find_restaurant
  load_and_authorize_resource :except => [:create, :new]
  
  
  def new
    begin
      authorize! :create, @dish
      @dish = Dish.new
      respond_with @dish
    rescue CanCan::AccessDenied
      render :partial => 'shared/unauthorized_ajax', :locals =>
      {:error_message => t('dishes.login'), :append_to => '#dishes-notice'}
    end
  end
  
  def create
    @dish = Dish.new(params[:dish])
    authorize! :create, @dish
    @dish.user = current_user
    @dish.restaurant = @restaurant
    @dish.save
  end
  
  def update
    if @dish.update_attributes(params[:dish])
      head :ok
    else
     render json: @dish.errors, status: :unprocessable_entity
    end
  end
  
  private
  
  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end
  
end
