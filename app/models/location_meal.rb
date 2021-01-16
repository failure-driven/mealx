class LocationMeal < ApplicationRecord
  belongs_to :location, foreign_key: "location_id"
  belongs_to :meal, foreign_key: "meal_id"

  has_many :location_meal_food_items
  has_many :food_items, through: :location_meal_food_items

  has_many :location_meal_serving_times
  has_many :serving_times, through: :location_meal_serving_times
end
