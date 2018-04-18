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

ActiveRecord::Schema.define(version: 2018_04_18_020632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_applications", force: :cascade do |t|
    t.string "private_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "short_urls", force: :cascade do |t|
    t.string "destination"
    t.integer "travel_count", default: 0
    t.string "key"
    t.jsonb "limit_settings", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "api_applications_id"
    t.index ["api_applications_id"], name: "index_short_urls_on_api_applications_id"
    t.index ["key"], name: "index_short_urls_on_key", unique: true
  end

end
