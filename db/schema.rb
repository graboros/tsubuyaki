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

ActiveRecord::Schema.define(version: 20160126141133) do

  create_table "dm_messages", force: :cascade do |t|
    t.integer  "dm_id",      limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "dm_messages", ["dm_id"], name: "index_dm_messages_on_dm_id", using: :btree
  add_index "dm_messages", ["user_id"], name: "index_dm_messages_on_user_id", using: :btree

  create_table "dm_users", force: :cascade do |t|
    t.integer  "dm_id",      limit: 4
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "dm_users", ["dm_id"], name: "index_dm_users_on_dm_id", using: :btree
  add_index "dm_users", ["user_id"], name: "index_dm_users_on_user_id", using: :btree

  create_table "dms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "followings", force: :cascade do |t|
    t.integer  "following_id", limit: 4, null: false
    t.integer  "followed_id",  limit: 4, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "followings", ["followed_id"], name: "index_followings_on_followed_id", using: :btree
  add_index "followings", ["following_id"], name: "index_followings_on_following_id", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4, null: false
    t.integer  "tweet_id",   limit: 4, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "likes", ["tweet_id"], name: "index_likes_on_tweet_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",      limit: 4,     null: false
    t.text     "introduction", limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "image",        limit: 255
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "retweetings", force: :cascade do |t|
    t.integer  "tweet_id",     limit: 4, null: false
    t.integer  "retweeted_id", limit: 4, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "retweetings", ["retweeted_id"], name: "index_retweetings_on_retweeted_id", using: :btree
  add_index "retweetings", ["tweet_id"], name: "index_retweetings_on_tweet_id", using: :btree

  create_table "tweets", force: :cascade do |t|
    t.integer  "user_id",    limit: 4,     null: false
    t.text     "content",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "retweet_id", limit: 4
  end

  add_index "tweets", ["retweet_id"], name: "fk_rails_7caf97240b", using: :btree
  add_index "tweets", ["user_id"], name: "index_tweets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "username",               limit: 255
    t.integer  "tweets_count",           limit: 4,   default: 0,  null: false
    t.integer  "followings_count",       limit: 4,   default: 0,  null: false
    t.integer  "followers_count",        limit: 4,   default: 0,  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "dm_messages", "dms"
  add_foreign_key "dm_messages", "users"
  add_foreign_key "dm_users", "dms"
  add_foreign_key "dm_users", "users"
  add_foreign_key "followings", "users", column: "followed_id"
  add_foreign_key "followings", "users", column: "following_id"
  add_foreign_key "likes", "tweets"
  add_foreign_key "likes", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "retweetings", "tweets"
  add_foreign_key "retweetings", "tweets", column: "retweeted_id"
  add_foreign_key "tweets", "tweets", column: "retweet_id"
  add_foreign_key "tweets", "users"
end
