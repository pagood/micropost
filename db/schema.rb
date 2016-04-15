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

ActiveRecord::Schema.define(version: 20160412205756) do

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.integer  "reply_id"
  end

  create_table "contact_relationships", force: :cascade do |t|
    t.integer  "me_id"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "contact_relationships", ["me_id", "contact_id"], name: "index_contact_relationships_on_me_id_and_contact_id", unique: true
  add_index "contact_relationships", ["me_id"], name: "index_contact_relationships_on_me_id"

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "sender_last",   default: 0
    t.integer  "receiver_last", default: 0
  end

  add_index "conversations", ["receiver_id"], name: "index_conversations_on_receiver_id"
  add_index "conversations", ["sender_id", "receiver_id"], name: "index_conversations_on_sender_id_and_receiver_id", unique: true
  add_index "conversations", ["sender_id"], name: "index_conversations_on_sender_id"

  create_table "like_relationships", force: :cascade do |t|
    t.integer  "like_id"
    t.integer  "like_user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "like_relationships", ["like_id", "like_user_id"], name: "index_like_relationships_on_like_id_and_like_user_id", unique: true
  add_index "like_relationships", ["like_id"], name: "index_like_relationships_on_like_id"
  add_index "like_relationships", ["like_user_id"], name: "index_like_relationships_on_like_user_id"

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "content"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "photo"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "content"
  end

  add_index "posts", ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "following_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"
  add_index "relationships", ["following_id", "follower_id"], name: "index_relationships_on_following_id_and_follower_id", unique: true
  add_index "relationships", ["following_id"], name: "index_relationships_on_following_id"

  create_table "unread_conversations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "unread_conversations", ["conversation_id"], name: "index_unread_conversations_on_conversation_id"
  add_index "unread_conversations", ["user_id", "conversation_id"], name: "index_unread_conversations_on_user_id_and_conversation_id", unique: true
  add_index "unread_conversations", ["user_id"], name: "index_unread_conversations_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "remember_digest"
    t.string   "name"
    t.string   "user_name"
    t.string   "phone"
    t.string   "sex"
    t.string   "bio"
    t.string   "website"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "avatar"
    t.string   "header"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["user_name"], name: "index_users_on_user_name", unique: true

end
