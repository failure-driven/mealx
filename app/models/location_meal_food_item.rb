class LocationMealFoodItem < ApplicationRecord
  belongs_to :location_meal
  belongs_to :food_item
end
