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

ActiveRecord::Schema.define(version: 20160713023708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["proposal_id"], name: "index_comments_on_proposal_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.text     "description"
    t.date     "occurs_at"
    t.string   "picture",         limit: 255
    t.string   "url",             limit: 255
    t.string   "twitter",         limit: 255
    t.integer  "user_id"
    t.date     "starts_votes_at"
    t.date     "end_votes_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",            limit: 255
    t.integer  "proposals_count"
    t.datetime "closed_at"
  end

  add_index "events", ["slug"], name: "index_events_on_slug", unique: true, using: :btree

  create_table "proposals", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "comments_count",             default: 0
  end

  add_index "proposals", ["event_id"], name: "index_proposals_on_event_id", using: :btree

  create_table "slugs", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "sluggable_id"
    t.integer  "sequence",                   default: 1, null: false
    t.string   "sluggable_type", limit: 40
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], name: "index_slugs_on_n_s_s_and_s", unique: true, using: :btree
  add_index "slugs", ["sluggable_id"], name: "index_slugs_on_sluggable_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255
    t.string   "encrypted_password",     limit: 128
    t.string   "password_salt",          limit: 255
    t.string   "reset_password_token",   limit: 255
    t.string   "remember_token",         limit: 255
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.datetime "reset_password_sent_at"
    t.string   "photo",                  limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.boolean  "lock_profile",                       default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "direction"
    t.integer  "proposal_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["proposal_id", "user_id"], name: "index_votes_on_proposal_id_and_user_id", unique: true, using: :btree

end
