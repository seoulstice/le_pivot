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

ActiveRecord::Schema.define(version: 20180216065249) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_keys", force: :cascade do |t|
    t.string "key", null: false
    t.bigint "user_id"
    t.index ["key", "user_id"], name: "index_api_keys_on_key_and_user_id"
    t.index ["key"], name: "index_api_keys_on_key", unique: true
    t.index ["user_id"], name: "index_api_keys_on_user_id", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "topic"
    t.string "slug"
    t.index ["slug"], name: "index_chatrooms_on_slug", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.float "price"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "condition", default: 0
    t.bigint "store_id"
    t.string "image"
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["store_id"], name: "index_items_on_store_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "chatroom_id"
    t.bigint "user_id"
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.index ["item_id"], name: "index_order_items_on_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_price"
    t.float "total_price_with_shipping"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "password_recoveries", force: :cascade do |t|
    t.string "code"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_password_recoveries_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.string "slug"
    t.index ["slug"], name: "index_stores_on_slug", unique: true
    t.index ["status"], name: "index_stores_on_status"
  end

  create_table "twitter_accounts", force: :cascade do |t|
    t.string "uid"
    t.string "screen_name"
    t.string "oauth_token"
    t.string "oauth_token_secret"
    t.bigint "store_id"
    t.index ["store_id"], name: "index_twitter_accounts_on_store_id"
    t.index ["uid"], name: "index_twitter_accounts_on_uid", unique: true
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "store_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["store_id"], name: "index_user_roles_on_store_id"
    t.index ["user_id", "store_id"], name: "index_user_roles_on_user_id_and_store_id", unique: true
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.string "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "items", "categories"
  add_foreign_key "items", "stores"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "password_recoveries", "users"
  add_foreign_key "twitter_accounts", "stores"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "stores"
  add_foreign_key "user_roles", "users"
end
