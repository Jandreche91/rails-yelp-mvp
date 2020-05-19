# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def add_reviews(restaurant)
  10.times do
    a_review = Review.new
    a_review.rating = rand(5)
    a_review.content = Faker::Restaurant.review
    a_review.restaurant = restaurant
    a_review.save
    puts "#{a_review.id}  review added to restaurant #{restaurant.id}"
  end
end

valid_categories = %w(chinese italian japanese french belgian)

100.times do

  new_restaurant = Restaurant.new
  new_restaurant.name = Faker::Restaurant.name
  new_restaurant.address = Faker::Address.full_address
  new_restaurant.category = valid_categories.sample
  new_restaurant.phone_number = Faker::PhoneNumber.phone_number_with_country_code
  new_restaurant.save
  puts "Restaurant #{new_restaurant.id} was saved successfully" if new_restaurant.valid?
  add_reviews(new_restaurant)
end
