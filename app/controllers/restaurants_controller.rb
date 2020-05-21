class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @review_hash = {}
    @restaurants.each do |restaurant|
      rating = 0
      restaurant.reviews.each { |review| rating += review.rating }
      @review_hash[restaurant.id] = rating.div(restaurant.reviews.count)
    end
    @review_hash = @review_hash.sort_by { |_key, value| -value }.to_h
  end

  def show
  end
end
