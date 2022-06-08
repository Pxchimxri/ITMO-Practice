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

ActiveRecord::Schema[7.0].define(version: 2022_06_07_204043) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "messages", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "options_orders", id: false, force: :cascade do |t|
    t.bigint "option_id", null: false
    t.bigint "order_id", null: false
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.float "interest_rate", null: false
    t.integer "price", null: false
    t.string "from"
    t.string "to"
    t.integer "client_rating"
    t.integer "driver_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "order_status_id", null: false
    t.bigint "message_id", null: false
    t.bigint "tariff_id", null: false
    t.bigint "user_client_id", null: false
    t.bigint "user_driver_id", null: false
    t.index ["message_id"], name: "index_orders_on_message_id"
    t.index ["order_status_id"], name: "index_orders_on_order_status_id"
    t.index ["tariff_id"], name: "index_orders_on_tariff_id"
    t.index ["user_client_id"], name: "index_orders_on_user_client_id"
    t.index ["user_driver_id"], name: "index_orders_on_user_driver_id"
  end

  create_table "tariffs", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "balance"
    t.float "rating"
    t.boolean "active", null: false
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "cur_order_id"
    t.bigint "type_id", null: false
    t.index ["type_id"], name: "index_users_on_type_id"
  end

  add_foreign_key "orders", "messages"
  add_foreign_key "orders", "order_statuses"
  add_foreign_key "orders", "tariffs"
  add_foreign_key "orders", "users", column: "user_client_id"
  add_foreign_key "orders", "users", column: "user_driver_id"
  add_foreign_key "users", "types"
end
