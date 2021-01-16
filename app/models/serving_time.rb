class ServingTime < ApplicationRecord
  has_many :location_meal_serving_times
  has_many :location_meals, through: :location_meal_serving_times

  validates :period_start_time, presence: true
  validates :period_end_time, presence: true
end
