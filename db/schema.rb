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

ActiveRecord::Schema.define(version: 20160210210107) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "avatars", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.integer  "skill_set_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "status",       default: "active"
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
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "location_id"
    t.integer  "equipped_armor_id"
    t.integer  "equipped_weapon_id"
  end

  add_index "characters", ["avatar_id"], name: "index_characters_on_avatar_id", using: :btree
  add_index "characters", ["location_id"], name: "index_characters_on_location_id", using: :btree
  add_index "characters", ["user_id"], name: "index_characters_on_user_id", using: :btree

  create_table "incidents", force: :cascade do |t|
    t.integer  "skill_set_id"
    t.integer  "character_id"
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "label"
    t.integer  "category_id"
  end

  add_index "incidents", ["category_id"], name: "index_incidents_on_category_id", using: :btree
  add_index "incidents", ["character_id"], name: "index_incidents_on_character_id", using: :btree
  add_index "incidents", ["skill_set_id"], name: "index_incidents_on_skill_set_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "category_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "itemable_id"
    t.string   "itemable_type"
    t.integer  "skill_set_id"
    t.string   "label"
  end

  add_index "items", ["category_id"], name: "index_items_on_category_id", using: :btree
  add_index "items", ["skill_set_id"], name: "index_items_on_skill_set_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string  "name"
    t.string  "slug"
    t.integer "next_location_id"
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
    t.integer  "defense"
  end

  create_table "stores", force: :cascade do |t|
    t.integer  "location_id"
    t.integer  "category_id"
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "stores", ["category_id"], name: "index_stores_on_category_id", using: :btree
  add_index "stores", ["location_id"], name: "index_stores_on_location_id", using: :btree

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
  add_foreign_key "incidents", "categories"
  add_foreign_key "incidents", "characters"
  add_foreign_key "incidents", "skill_sets"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "skill_sets"
  add_foreign_key "stores", "categories"
  add_foreign_key "stores", "locations"
end
