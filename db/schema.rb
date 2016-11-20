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

ActiveRecord::Schema.define(version: 20161120080627) do

  create_table "brands", force: :cascade do |t|
    t.string   "BrandName"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "details", force: :cascade do |t|
    t.boolean  "IsShow"
    t.string   "DetailName"
    t.text     "Feature"
    t.text     "HealthyFeature"
    t.text     "HealthyTip"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "series_id"
    t.index ["series_id"], name: "index_details_on_series_id"
  end

  create_table "p_classes", force: :cascade do |t|
    t.string   "SNColor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "detail_id"
    t.index ["detail_id"], name: "index_p_classes_on_detail_id"
  end

  create_table "p_metadata", force: :cascade do |t|
    t.string   "SN"
    t.string   "Volume"
    t.integer  "Price"
    t.string   "Color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "class_id"
    t.index ["class_id"], name: "index_p_metadata_on_class_id"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "type"
    t.integer  "refer_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "series", force: :cascade do |t|
    t.string   "SeriesName"
    t.string   "TitleColor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "brand_id"
    t.index ["brand_id"], name: "index_series_on_brand_id"
  end

end
