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

ActiveRecord::Schema.define(version: 20160528141815) do

  create_table "evenements", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "titre",       limit: 255
    t.text     "description", limit: 65535
    t.string   "lieu_evenmt", limit: 255
    t.datetime "date_evenmt"
    t.string   "lieu_rdv",    limit: 255
    t.datetime "date_rdv"
    t.string   "prix",        limit: 255
    t.integer  "nbmax",       limit: 4
    t.string   "statut",      limit: 255
    t.text     "theme",       limit: 65535
    t.text     "mot_cle",     limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "evenements", ["user_id"], name: "index_evenements_on_user_id", using: :btree

  create_table "friendships", force: :cascade do |t|
    t.integer  "sender_id",   limit: 4
    t.integer  "receiver_id", limit: 4
    t.integer  "status",      limit: 4, default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["receiver_id"], name: "index_friendships_on_receiver_id", using: :btree
  add_index "friendships", ["sender_id", "receiver_id"], name: "index_friendships_on_sender_id_and_receiver_id", unique: true, using: :btree
  add_index "friendships", ["sender_id"], name: "index_friendships_on_sender_id", using: :btree

  create_table "microposts", force: :cascade do |t|
    t.string   "content",    limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "userfacebooks", force: :cascade do |t|
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "name",             limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "nom",                limit: 255
    t.string   "email",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password", limit: 255
    t.string   "salt",               limit: 255
    t.boolean  "admin",                          default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
