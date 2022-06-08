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

ActiveRecord::Schema[7.0].define(version: 2022_06_07_211953) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options_orders", id: false, force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "option_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["option_id"], name: "index_options_orders_on_option_id"
    t.index ["order_id"], name: "index_options_orders_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "price"
    t.float "interest_rate"
    t.string "tariff"
    t.string "status"
    t.string "from"
    t.string "to"
    t.integer "client_rating"
    t.integer "driver_rating"
    t.bigint "client_id", null: false
    t.bigint "driver_id", null: false
    t.bigint "message_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["driver_id"], name: "index_orders_on_driver_id"
    t.index ["message_id"], name: "index_orders_on_message_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.decimal "balance"
    t.float "rating"
    t.boolean "active"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "orders", "messages"
  add_foreign_key "orders", "users", column: "client_id"
  add_foreign_key "orders", "users", column: "driver_id"
end
