class FoodItem < ApplicationRecord
  has_many :location_meal_food_items
  has_many :location_meals, through: :location_meal_food_items
end
