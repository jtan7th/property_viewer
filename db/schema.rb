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

ActiveRecord::Schema[7.1].define(version: 2024_10_18_022141) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "properties", force: :cascade do |t|
    t.string "url"
    t.string "address"
    t.integer "sale_price"
    t.date "sold_date"
    t.date "homes_estimate_date"
    t.integer "homes_estimate_price"
    t.integer "homes_estimate_range_low"
    t.integer "homes_estimate_range_high"
    t.integer "bedroom_count"
    t.integer "bathroom_count"
    t.integer "carpark_spaces_count"
    t.integer "floor_area"
    t.integer "land_area"
    t.string "deck"
    t.string "property_contour"
    t.string "view_type"
    t.string "decade_built"
    t.string "view_living_area"
    t.string "condition"
    t.string "suburb"
    t.integer "capital_valuation"
    t.date "capital_valuation_date"
    t.integer "land_value"
    t.integer "improvement_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_urls", default: [], array: true
    t.boolean "image_download_in_progress"
    t.boolean "image_download_failed"
    t.string "download_job_id"
    t.integer "expected_image_count"
    t.datetime "last_updated", precision: nil
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
