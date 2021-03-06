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

ActiveRecord::Schema.define(version: 20120227160337) do

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "username"
    t.string   "user_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["id", "post_id"], name: "index_comments_on_id_and_post_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["title"], name: "index_posts_on_title"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "taggables", force: true do |t|
    t.integer "tag_id"
    t.integer "post_id"
  end

  create_table "tags", force: true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name"

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "posts_count",   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
