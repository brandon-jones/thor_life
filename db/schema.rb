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

ActiveRecord::Schema.define(version: 20150206043141) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "admin_type"
    t.integer  "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.integer  "price_in_cents"
    t.integer  "cart_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "cart_items", ["item_id"], name: "index_cart_items_on_item_id", using: :btree

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "total_in_cents"
    t.boolean  "delivered",      default: false
    t.integer  "delivered_by"
    t.datetime "delivered_on"
    t.integer  "donation_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "created_by"
    t.text     "body"
    t.integer  "topic_id"
    t.boolean  "deleted"
    t.integer  "deleted_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forums", force: :cascade do |t|
    t.integer  "parent_id"
    t.integer  "row_order"
    t.integer  "created_by"
    t.string   "title"
    t.integer  "deleted_by"
    t.integer  "grouping_id"
    t.boolean  "locked",           default: false
    t.boolean  "topics_allowed",   default: true
    t.boolean  "admins_only",      default: false
    t.boolean  "main_feed",        default: false
    t.boolean  "deleted",          default: false
    t.datetime "last_updated"
    t.integer  "game_id"
    t.integer  "game_instance_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "forums", ["grouping_id"], name: "index_forums_on_grouping_id", using: :btree
  add_index "forums", ["last_updated"], name: "index_forums_on_last_updated", using: :btree
  add_index "forums", ["row_order"], name: "index_forums_on_row_order", using: :btree
  add_index "forums", ["title"], name: "index_forums_on_title", using: :btree

  create_table "game_instances", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "server_name"
    t.string   "server_address"
    t.integer  "server_port"
    t.text     "mod_list"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "game_instances", ["game_id"], name: "index_game_instances_on_game_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "games", ["name"], name: "index_games_on_name", using: :btree

  create_table "groupings", force: :cascade do |t|
    t.string   "title"
    t.integer  "row_order"
    t.integer  "forum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groupings", ["forum_id"], name: "index_groupings_on_forum_id", using: :btree
  add_index "groupings", ["row_order"], name: "index_groupings_on_row_order", using: :btree
  add_index "groupings", ["title"], name: "index_groupings_on_title", using: :btree

  create_table "packages", force: :cascade do |t|
    t.string   "title"
    t.integer  "price_in_cents"
    t.string   "perk_ids"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "perks", force: :cascade do |t|
    t.string   "title"
    t.integer  "game_instance_id"
    t.text     "description"
    t.integer  "price_in_cents"
    t.integer  "game_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "perks", ["game_id"], name: "index_perks_on_game_id", using: :btree

  create_table "topics", force: :cascade do |t|
    t.string   "title"
    t.integer  "created_by"
    t.boolean  "sticky",         default: false
    t.text     "body"
    t.boolean  "locked",         default: false
    t.boolean  "deleted",        default: false
    t.integer  "deleted_by"
    t.datetime "last_updated"
    t.integer  "forum_id"
    t.integer  "comments_count"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "topics", ["forum_id"], name: "index_topics_on_forum_id", using: :btree
  add_index "topics", ["last_updated"], name: "index_topics_on_last_updated", using: :btree
  add_index "topics", ["sticky"], name: "index_topics_on_sticky", using: :btree
  add_index "topics", ["title"], name: "index_topics_on_title", using: :btree

  create_table "user_game_ids", force: :cascade do |t|
    t.integer  "game_id"
    t.string   "in_game_name"
    t.integer  "user_id"
    t.boolean  "banned"
    t.boolean  "permma_banned"
    t.boolean  "user_verified"
    t.integer  "verified_by"
    t.boolean  "banned_by"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "user_game_ids", ["game_id"], name: "index_user_game_ids_on_game_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.string   "email"
    t.boolean  "email_verified",  default: false
    t.string   "phone_number"
    t.string   "phone_provider"
    t.text     "about_me"
    t.boolean  "banned",          default: false
    t.boolean  "permma_banned",   default: false
    t.integer  "banned_by"
    t.string   "customer_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
