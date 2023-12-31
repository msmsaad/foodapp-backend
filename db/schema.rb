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

ActiveRecord::Schema[7.0].define(version: 2023_07_26_080349) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "carts_meals", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "meal_id", null: false
    t.integer "quantity", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_carts_meals_on_cart_id"
    t.index ["meal_id"], name: "index_carts_meals_on_meal_id"
  end

  create_table "meals", force: :cascade do |t|
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "thumbnail"
    t.string "stripe_product_id"
    t.string "stripe_price_id"
  end

  create_table "ordered_meals", force: :cascade do |t|
    t.integer "quantity", default: 1, null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.bigint "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "meal_id", null: false
    t.index ["meal_id"], name: "index_ordered_meals_on_meal_id"
    t.index ["order_id"], name: "index_ordered_meals_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "stripe_payment_id"
    t.index ["stripe_payment_id"], name: "index_orders_on_stripe_payment_id", unique: true
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name"
    t.string "nickname"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "carts", "users"
  add_foreign_key "carts_meals", "carts"
  add_foreign_key "carts_meals", "meals"
  add_foreign_key "ordered_meals", "meals"
  add_foreign_key "ordered_meals", "orders"
  add_foreign_key "orders", "users"
end
