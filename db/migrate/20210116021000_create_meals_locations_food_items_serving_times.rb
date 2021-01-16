class CreateMealsLocationsFoodItemsServingTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :locations, id: :uuid do |t|
      t.string :name, null: false
      t.string :address
      t.decimal :latitude, precision: 10, scale: 6, default: 0
      t.decimal :longitude, precision: 10, scale: 6, default: 0
    end

    create_table :meals, id: :uuid do |t|
      t.string :name, null: false
    end

    create_table :food_items, id: :uuid do |t|
      t.string :name, null: false
    end

    create_table :serving_times, id: :uuid do |t|
      t.string :name, null: false
      t.string :day
      t.time :period_start_time, null: false
      t.time :period_end_time, null: false
    end

    create_table :location_meals, id: :uuid do |t|
      t.string :name, null: false
      t.string :description
      t.string :image
      t.integer :price_cents
      t.belongs_to :location, foreign_key: true, null: false, type: :uuid, index: true
      t.belongs_to :meal, foreign_key: true, null: false, type: :uuid, index: true
      t.timestamps
    end

    create_table :location_meal_food_items, id: false do |t|
      t.belongs_to :location_meal, foreign_key: true, null: false, type: :uuid
      t.belongs_to :food_item, foreign_key: true, null: false, type: :uuid
    end

    create_table :location_meal_serving_times, id: false do |t|
      t.belongs_to :location_meal, foreign_key: true, null: false, type: :uuid
      t.belongs_to :serving_time, foreign_key: true, null: false, type: :uuid
    end
  end
end
