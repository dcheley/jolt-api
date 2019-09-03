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

ActiveRecord::Schema.define(version: 2019_09_03_152623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feedbacks", force: :cascade do |t|
    t.text "message", null: false
    t.bigint "user_id"
    t.bigint "merchant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_feedbacks_on_merchant_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "merchants", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "address"
    t.string "postal_code"
    t.string "phone"
    t.string "category"
    t.index ["user_id"], name: "index_merchants_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "title", null: false
    t.string "category"
    t.decimal "dollar_value", precision: 8, scale: 2
    t.date "expiary_date"
    t.bigint "merchant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_offers_on_merchant_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.string "title", null: false
    t.string "category"
    t.decimal "dollar_value", precision: 8, scale: 2
    t.date "expiary_date"
    t.integer "merchant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_promotions_on_merchant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.integer "role"
  end

  add_foreign_key "feedbacks", "merchants"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "merchants", "users"
  add_foreign_key "offers", "merchants"
end
