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

ActiveRecord::Schema.define(version: 20151228073614) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.string   "gamertag",     null: false
    t.integer  "spartan_rank", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "service_records", force: :cascade do |t|
    t.integer  "player_id",                null: false
    t.integer  "game_mode",    default: 0, null: false
    t.integer  "kills",                    null: false
    t.integer  "assists",                  null: false
    t.integer  "deaths",                   null: false
    t.integer  "games_played",             null: false
    t.integer  "games_won",                null: false
    t.integer  "time_played",              null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "service_records", ["player_id", "game_mode"], name: "index_service_records_on_player_id_and_game_mode", unique: true, using: :btree
  add_index "service_records", ["player_id"], name: "index_service_records_on_player_id", using: :btree

  create_table "weapons", force: :cascade do |t|
    t.string   "uid",              null: false
    t.string   "name",             null: false
    t.string   "weapon_type",      null: false
    t.text     "description"
    t.text     "image_url"
    t.boolean  "usable_by_player"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "weapons", ["uid"], name: "index_weapons_on_uid", unique: true, using: :btree

  add_foreign_key "service_records", "players", name: "fk_service_records_player_id"
end
