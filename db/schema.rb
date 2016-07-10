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

ActiveRecord::Schema.define(version: 20160710190414) do

  create_table "approbations", force: :cascade do |t|
    t.integer  "temoignage_id", limit: 4
    t.integer  "approuver_id",  limit: 4
    t.boolean  "approuve"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "approbations", ["approuver_id"], name: "index_approbations_on_approuver_id", using: :btree
  add_index "approbations", ["temoignage_id", "approuver_id"], name: "index_approbations_on_temoignage_id_and_approuver_id", unique: true, using: :btree
  add_index "approbations", ["temoignage_id"], name: "index_approbations_on_temoignage_id", using: :btree

  create_table "commentaires", force: :cascade do |t|
    t.integer  "commentateur_id", limit: 4
    t.integer  "evenement_id",    limit: 4
    t.text     "commentaire",     limit: 65535
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "commentaires", ["commentateur_id"], name: "index_commentaires_on_commentateur_id", using: :btree
  add_index "commentaires", ["evenement_id"], name: "index_commentaires_on_evenement_id", using: :btree

  create_table "evenements", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "titre",        limit: 255
    t.text     "description",  limit: 65535
    t.string   "lieu_evenmt",  limit: 255
    t.datetime "date_evenmt"
    t.string   "lieu_rdv",     limit: 255
    t.datetime "date_rdv"
    t.string   "prix",         limit: 255
    t.integer  "nbmax",        limit: 4
    t.string   "statut",       limit: 255
    t.text     "theme",        limit: 65535
    t.text     "mot_cle",      limit: 65535
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.time     "heure_evenmt",               default: '2000-01-01 00:00:00'
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

  create_table "inscriptions", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "evenement_id", limit: 4
    t.string   "etat",         limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "inscriptions", ["evenement_id"], name: "index_inscriptions_on_evenement_id", using: :btree
  add_index "inscriptions", ["user_id", "evenement_id"], name: "index_inscriptions_on_user_id_and_evenement_id", unique: true, using: :btree
  add_index "inscriptions", ["user_id"], name: "index_inscriptions_on_user_id", using: :btree

  create_table "interesses", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "evenement_id", limit: 4
    t.boolean  "interesse"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "interesses", ["evenement_id"], name: "index_interesses_on_evenement_id", using: :btree
  add_index "interesses", ["user_id", "evenement_id"], name: "index_interesses_on_user_id_and_evenement_id", unique: true, using: :btree
  add_index "interesses", ["user_id"], name: "index_interesses_on_user_id", using: :btree

  create_table "jaimes", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "evenement_id", limit: 4
    t.boolean  "jaime"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "jaimes", ["evenement_id"], name: "index_jaimes_on_evenement_id", using: :btree
  add_index "jaimes", ["user_id", "evenement_id"], name: "index_jaimes_on_user_id_and_evenement_id", unique: true, using: :btree
  add_index "jaimes", ["user_id"], name: "index_jaimes_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id",   limit: 4
    t.integer  "receiver_id", limit: 4
    t.text     "message",     limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "i_sup",                     default: false
  end

  add_index "messages", ["i_sup"], name: "index_messages_on_i_sup", using: :btree
  add_index "messages", ["receiver_id"], name: "index_messages_on_receiver_id", using: :btree
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id", using: :btree

  create_table "microposts", force: :cascade do |t|
    t.string   "content",    limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "proasuivres", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "pro_id",     limit: 4
    t.boolean  "asuivre"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "proasuivres", ["pro_id"], name: "index_proasuivres_on_pro_id", using: :btree
  add_index "proasuivres", ["user_id", "pro_id"], name: "index_proasuivres_on_user_id_and_pro_id", unique: true, using: :btree
  add_index "proasuivres", ["user_id"], name: "index_proasuivres_on_user_id", using: :btree

  create_table "projaimes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "pro_id",     limit: 4
    t.boolean  "projaime"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "projaimes", ["pro_id"], name: "index_projaimes_on_pro_id", using: :btree
  add_index "projaimes", ["user_id", "pro_id"], name: "index_projaimes_on_user_id_and_pro_id", unique: true, using: :btree
  add_index "projaimes", ["user_id"], name: "index_projaimes_on_user_id", using: :btree

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id", limit: 4
    t.integer  "followed_id", limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "reponses", force: :cascade do |t|
    t.text     "reponse",        limit: 65535
    t.integer  "user_id",        limit: 4
    t.integer  "commentaire_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "reponses", ["commentaire_id"], name: "index_reponses_on_commentaire_id", using: :btree
  add_index "reponses", ["user_id"], name: "index_reponses_on_user_id", using: :btree

  create_table "signalements", force: :cascade do |t|
    t.integer  "id_signaleur", limit: 4
    t.text     "signalement",  limit: 65535
    t.boolean  "validation",                 default: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "pro_id",       limit: 4
  end

  add_index "signalements", ["id_signaleur"], name: "index_signalements_on_id_signaleur", using: :btree
  add_index "signalements", ["pro_id"], name: "index_signalements_on_pro_id", using: :btree

  create_table "signalevens", force: :cascade do |t|
    t.integer  "id_signaleur", limit: 4
    t.text     "signalement",  limit: 65535
    t.boolean  "validation",                 default: false
    t.integer  "even_id",      limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "signalevens", ["even_id"], name: "index_signalevens_on_even_id", using: :btree
  add_index "signalevens", ["id_signaleur"], name: "index_signalevens_on_id_signaleur", using: :btree

  create_table "temoignages", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "pro_id",     limit: 4
    t.text     "temoignage", limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "temoignages", ["pro_id"], name: "index_temoignages_on_pro_id", using: :btree
  add_index "temoignages", ["user_id"], name: "index_temoignages_on_user_id", using: :btree

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
    t.boolean  "pro"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "reponses", "commentaires"
  add_foreign_key "reponses", "users"
end
