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

ActiveRecord::Schema.define(version: 2019_11_12_162855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advertisements", force: :cascade do |t|
    t.string "title", null: false
    t.string "category"
    t.decimal "dollar_value", precision: 8, scale: 2
    t.date "expiry_date"
    t.integer "merchant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_advertisements_on_merchant_id"
  end

  create_table "billings", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "institution", null: false
    t.string "credit_card_number", null: false
    t.string "credit_expiry_date", null: false
    t.string "cvv", null: false
    t.string "address"
    t.string "city"
    t.string "postal_code"
    t.string "province"
    t.string "phone"
    t.bigint "merchant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_customer_id"
    t.index ["merchant_id"], name: "index_billings_on_merchant_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "events", force: :cascade do |t|
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.bigint "offer_id"
    t.text "description"
    t.datetime "next_date"
    t.string "occurrence", default: "none"
    t.index ["offer_id"], name: "index_events_on_offer_id"
  end

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
    t.date "expiry_date"
    t.bigint "merchant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["merchant_id"], name: "index_offers_on_merchant_id"
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

  add_foreign_key "billings", "merchants"
  add_foreign_key "events", "offers"
  add_foreign_key "feedbacks", "merchants"
  add_foreign_key "feedbacks", "users"
  add_foreign_key "merchants", "users"
  add_foreign_key "offers", "merchants"
end
