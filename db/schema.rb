# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161120104955) do

  create_table "brands", force: :cascade do |t|
    t.string   "BrandName",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["BrandName"], name: "index_brands_on_BrandName", unique: true
  end

  create_table "composition_images", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "detail_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["detail_id"], name: "index_composition_images_on_detail_id"
  end

  create_table "detail_images", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "detail_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["detail_id"], name: "index_detail_images_on_detail_id"
  end

  create_table "details", force: :cascade do |t|
    t.boolean  "IsShow",         default: true, null: false
    t.string   "DetailName",                    null: false
    t.text     "Feature"
    t.text     "HealthyFeature"
    t.text     "HealthyTip"
    t.string   "SNColor"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "series_id"
    t.index ["series_id"], name: "index_details_on_series_id"
  end

  create_table "feature_images", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "detail_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["detail_id"], name: "index_feature_images_on_detail_id"
  end

  create_table "p_metadata", force: :cascade do |t|
    t.string   "SN",         null: false
    t.string   "Volume"
    t.integer  "Price"
    t.string   "Color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "detail_id"
    t.index ["detail_id"], name: "index_p_metadata_on_detail_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "mtype"
    t.integer  "refer_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "qr_images", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "metadata_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["metadata_id"], name: "index_qr_images_on_metadata_id"
  end

  create_table "series", force: :cascade do |t|
    t.string   "SeriesName", null: false
    t.string   "TitleColor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "brand_id"
    t.index ["SeriesName"], name: "index_series_on_SeriesName"
    t.index ["brand_id"], name: "index_series_on_brand_id"
  end

end
