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

ActiveRecord::Schema[7.1].define(version: 2024_09_02_202142) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "properties", force: :cascade do |t|
    t.string "url"
    t.string "address"
    t.string "sale_price"
    t.date "sold_date"
    t.date "homes_estimate_date"
    t.string "homes_estimate_price"
    t.string "homes_estimate_range_low"
    t.string "homes_estimate_range_high"
    t.integer "bedroom_count"
    t.integer "bathroom_count"
    t.integer "carpark_spaces_count"
    t.string "floor_area"
    t.string "land_area"
    t.string "deck"
    t.string "property_contour"
    t.string "view_type"
    t.string "decade_built"
    t.string "view_living_area"
    t.string "condition"
    t.string "suburb"
    t.string "capital_valuation"
    t.date "capital_valuation_date"
    t.string "land_value"
    t.string "improvement_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
