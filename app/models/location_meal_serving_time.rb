class LocationMealServingTime < ApplicationRecord
  belongs_to :location_meal
  belongs_to :serving_time
end
