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

ActiveRecord::Schema.define(version: 20171108053751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "registered_at", null: false
    t.string "address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "postal_code", null: false
    t.string "phone", null: false
    t.integer "movies_checked_out_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "account_credit"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.string "overview", null: false
    t.string "release_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "inventory"
    t.integer "available_inventory"
  end

  create_table "rentals", force: :cascade do |t|
    t.integer "movie_id"
    t.integer "customer_id"
    t.string "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "checkout_date"
    t.boolean "returned", default: false
    t.index ["movie_id", "customer_id"], name: "index_rentals_on_movie_id_and_customer_id"
  end

end
