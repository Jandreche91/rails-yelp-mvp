class RestaurantsController < ApplicationController

  before_action :set_restaurant, only: [:show]

  def index
    @restaurants = Restaurant.all
    @review_hash = {}
    @restaurants.each do |restaurant|
      rating = 0
      restaurant.reviews.each { |review| rating += review.rating }
      if restaurant.reviews.empty?
        @review_hash[restaurant.id] = 0
      else
        @review_hash[restaurant.id] = rating.div(restaurant.reviews.count)
      end
    end
    @review_hash = @review_hash.sort_by { |_key, value| -value }.to_h
  end

  def show
    @rating = 0
    @restaurant.reviews.each { |review| @rating += review.rating }
    @rating /= @restaurant.reviews.count unless @restaurant.reviews.empty?
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone_number,:category)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end


end
