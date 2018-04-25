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

ActiveRecord::Schema.define(version: 2018_04_25_184815) do

  create_table "journeys", force: :cascade do |t|
    t.string "code", limit: 20
    t.string "start", limit: 255
    t.string "end", limit: 255
    t.integer "capacity", limit: 2
    t.integer "price", limit: 3
    t.integer "duration", limit: 3
    t.string "status", limit: 15, default: "new"
    t.text "tags"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "journeys_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "journey_id", null: false
  end

  create_table "stops", force: :cascade do |t|
    t.integer "journey_id"
    t.integer "user_id"
    t.string "latitude"
    t.string "longitude"
    t.index ["journey_id"], name: "index_stops_on_journey_id"
    t.index ["user_id"], name: "index_stops_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "coins", limit: 3
    t.string "status", limit: 15
    t.integer "kind"
    t.string "transaction_code", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "cc", limit: 15
    t.integer "coins", limit: 3, default: 10
    t.string "email", limit: 255
    t.string "phone", limit: 10
    t.string "password", limit: 255
    t.integer "role", limit: 1
    t.float "latitude", limit: 10, default: 0.0
    t.float "longitude", limit: 10, default: 0.0
    t.string "profile_picture", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
