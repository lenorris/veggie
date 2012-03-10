class RestaurantsController < ApplicationController
  before_filter :find_restaurant, :except => [:index, :new, :create]
  add_breadcrumb I18n.t('breadcrumbs.controllers.restaurants'), :restaurants_path
  load_and_authorize_resource

  # GET /restaurants
  # GET /restaurants.json
  def index
    @restaurants = Restaurant.all
    @last_added = Restaurant.last_n(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @restaurants }
    end
  end

  # GET /restaurants/1
  # GET /restaurants/1.json
  def show
    add_breadcrumb @restaurant.name, restaurant_path(@restaurant)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @restaurant }
    end
  end

  # GET /restaurants/new
  # GET /restaurants/new.json
  def new
    add_breadcrumb I18n.t('breadcrumbs.restaurants.new'), new_restaurant_path
    @restaurant = Restaurant.new
    @restaurant.branches.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @restaurant }
    end
  end

  # GET /restaurants/1/edit
  def edit
    add_breadcrumb @restaurant.name, restaurant_path(@restaurant)
    add_breadcrumb I18n.t('breadcrumbs.restaurants.edit'), edit_restaurant_path

  end

  # POST /restaurants
  # POST /restaurants.json
  def create
    @restaurant = Restaurant.new(params[:restaurant])

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: t('succesfully_created') }
        format.json { render json: @restaurant, status: :created, location: @restaurant }
      else
        format.html { render action: "new" }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /restaurants/1
  # PUT /restaurants/1.json
  def update

    respond_to do |format|
      if @restaurant.update_attributes(params[:restaurant])
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /restaurants/1
  # DELETE /restaurants/1.json
  def destroy
    @restaurant.destroy

    respond_to do |format|
      format.html { redirect_to restaurants_url }
      format.json { head :ok }
    end
  end
  
  private
  
  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
  
end
