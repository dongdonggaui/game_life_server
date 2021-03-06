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

ActiveRecord::Schema.define(version: 20150829075637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string   "title"
    t.date     "publish_time"
    t.text     "game_bio"
    t.string   "company"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "statuses", ["user_id"], name: "index_statuses_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",                                                                      null: false
    t.datetime "updated_at",                                                                      null: false
    t.string   "nickname"
    t.string   "email"
    t.string   "phone"
    t.string   "province"
    t.string   "city"
    t.string   "location"
    t.string   "gender",          default: "m"
    t.string   "description"
    t.integer  "followers_count"
    t.integer  "friends_count"
    t.integer  "games_count"
    t.integer  "status_count"
    t.string   "avatar_url",      default: "http://img-storage.qiniudn.com/15-8-29/10112867.jpg"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
