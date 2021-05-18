# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2016_11_26_020317) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "csr_tiers", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "name"
    t.text "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_csr_tiers_on_identifier", unique: true
  end

  create_table "players", force: :cascade do |t|
    t.string "gamertag", null: false
    t.integer "spartan_rank", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "spartan_image_url"
    t.text "emblem_url"
    t.text "slug", null: false
    t.datetime "refreshed_at"
    t.text "completed_seasons", default: [], null: false, array: true
    t.index ["gamertag"], name: "index_players_on_gamertag", unique: true
    t.index ["slug"], name: "index_players_on_slug", unique: true
  end

  create_table "playlist_ranks", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "season_id", null: false
    t.integer "playlist_id", null: false
    t.integer "csr_tier_id", null: false
    t.integer "progress_percent"
    t.integer "csr"
    t.integer "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id", "season_id", "playlist_id"], name: "index_playlist_ranks_on_player_id_and_season_id_and_playlist_id", unique: true
    t.index ["player_id"], name: "index_playlist_ranks_on_player_id"
    t.index ["season_id"], name: "index_playlist_ranks_on_season_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "uid", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "game_mode", default: 0, null: false
    t.boolean "active", default: false, null: false
    t.boolean "ranked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_playlists_on_uid", unique: true
  end

  create_table "seasons", force: :cascade do |t|
    t.string "uid", null: false
    t.string "name", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_seasons_on_uid", unique: true
  end

  create_table "service_records", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "game_mode", default: 0, null: false
    t.integer "kills", null: false
    t.integer "assists", null: false
    t.integer "deaths", null: false
    t.integer "games_played", null: false
    t.integer "games_won", null: false
    t.integer "time_played", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id", "game_mode"], name: "index_service_records_on_player_id_and_game_mode", unique: true
    t.index ["player_id"], name: "index_service_records_on_player_id"
  end

  create_table "weapon_usages", force: :cascade do |t|
    t.integer "player_id", null: false
    t.integer "weapon_id", null: false
    t.integer "kills", default: 0, null: false
    t.integer "headshots", default: 0, null: false
    t.integer "damage_dealt", default: 0, null: false
    t.integer "shots_fired", default: 0, null: false
    t.integer "shots_hit", default: 0, null: false
    t.integer "time_used", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "game_mode", default: 0, null: false
    t.index ["game_mode", "player_id", "weapon_id"], name: "index_weapon_usages_on_game_mode_and_player_id_and_weapon_id", unique: true
    t.index ["game_mode", "player_id"], name: "index_weapon_usages_on_game_mode_and_player_id"
    t.index ["game_mode"], name: "index_weapon_usages_on_game_mode"
    t.index ["player_id"], name: "index_weapon_usages_on_player_id"
    t.index ["weapon_id"], name: "index_weapon_usages_on_weapon_id"
  end

  create_table "weapons", force: :cascade do |t|
    t.string "uid", null: false
    t.string "name", null: false
    t.string "weapon_type", null: false
    t.text "description"
    t.text "image_url"
    t.boolean "usable_by_player"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_weapons_on_uid", unique: true
  end

  add_foreign_key "playlist_ranks", "csr_tiers", name: "fk_playlist_ranks_csr_tier_id"
  add_foreign_key "playlist_ranks", "players", name: "fk_playlist_ranks_player_id"
  add_foreign_key "playlist_ranks", "playlists", name: "fk_playlist_ranks_playlist_id"
  add_foreign_key "playlist_ranks", "seasons", name: "fk_playlist_ranks_season_id"
  add_foreign_key "service_records", "players", name: "fk_service_records_player_id"
  add_foreign_key "weapon_usages", "players", name: "fk_weapon_usages_player_id"
  add_foreign_key "weapon_usages", "weapons", name: "fk_weapon_usages_weapon_id"
end
