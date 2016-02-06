# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160206222220) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avatars", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.integer  "skill_set_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "avatars", ["skill_set_id"], name: "index_avatars_on_skill_set_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "characters", force: :cascade do |t|
    t.integer  "avatar_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "location_id"
  end

  add_index "characters", ["avatar_id"], name: "index_characters_on_avatar_id", using: :btree
  add_index "characters", ["location_id"], name: "index_characters_on_location_id", using: :btree
  add_index "characters", ["user_id"], name: "index_characters_on_user_id", using: :btree

  create_table "chip_orders", force: :cascade do |t|
    t.integer "chip_id"
    t.integer "order_id"
    t.integer "quantity"
    t.float   "subtotal"
  end

  add_index "chip_orders", ["chip_id"], name: "index_chip_orders_on_chip_id", using: :btree
  add_index "chip_orders", ["order_id"], name: "index_chip_orders_on_order_id", using: :btree

  create_table "chips", force: :cascade do |t|
    t.string   "name"
    t.float    "price"
    t.string   "description"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "category_id"
    t.string   "slug"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "status",             default: "Available"
  end

  add_index "chips", ["category_id"], name: "index_chips_on_category_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "slug"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "status",      default: "Ordered"
    t.float    "total_price"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "address"
  end

  create_table "skill_sets", force: :cascade do |t|
    t.integer  "strength"
    t.integer  "dexterity"
    t.integer  "intelligence"
    t.integer  "health"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "money"
    t.integer  "speed"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "role",            default: 0
  end

  add_foreign_key "avatars", "skill_sets"
  add_foreign_key "characters", "avatars"
  add_foreign_key "characters", "locations"
  add_foreign_key "characters", "users"
  add_foreign_key "chip_orders", "chips"
  add_foreign_key "chip_orders", "orders"
  add_foreign_key "chips", "categories"
end
