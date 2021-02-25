# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_25_000000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "flipper_features", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "key", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["key"], name: "index_flipper_features_on_key", unique: true
  end

  create_table "flipper_gates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "feature_key", null: false
    t.string "key", null: false
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["feature_key", "key", "value"], name: "index_flipper_gates_on_feature_key_and_key_and_value", unique: true
  end

  create_table "food_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "location_meal_food_items", id: false, force: :cascade do |t|
    t.uuid "location_meal_id", null: false
    t.uuid "food_item_id", null: false
    t.index ["food_item_id"], name: "index_location_meal_food_items_on_food_item_id"
    t.index ["location_meal_id"], name: "index_location_meal_food_items_on_location_meal_id"
  end

  create_table "location_meal_serving_times", id: false, force: :cascade do |t|
    t.uuid "location_meal_id", null: false
    t.uuid "serving_time_id", null: false
    t.index ["location_meal_id"], name: "index_location_meal_serving_times_on_location_meal_id"
    t.index ["serving_time_id"], name: "index_location_meal_serving_times_on_serving_time_id"
  end

  create_table "location_meals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "image"
    t.integer "price_cents"
    t.uuid "location_id", null: false
    t.uuid "meal_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_location_meals_on_location_id"
    t.index ["meal_id"], name: "index_location_meals_on_meal_id"
  end

  create_table "locations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.decimal "latitude", precision: 10, scale: 6, default: "0.0"
    t.decimal "longitude", precision: 10, scale: 6, default: "0.0"
    t.text "menu_text"
  end

  create_table "meals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "serving_times", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "day"
    t.time "period_start_time", null: false
    t.time "period_end_time", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "user_actions"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "location_meal_food_items", "food_items"
  add_foreign_key "location_meal_food_items", "location_meals"
  add_foreign_key "location_meal_serving_times", "location_meals"
  add_foreign_key "location_meal_serving_times", "serving_times"
  add_foreign_key "location_meals", "locations"
  add_foreign_key "location_meals", "meals"
end
