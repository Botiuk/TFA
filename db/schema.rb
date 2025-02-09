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

ActiveRecord::Schema[7.2].define(version: 2024_08_22_080143) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "atributes", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price"
    t.integer "avaliable", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fan_matches", force: :cascade do |t|
    t.bigint "fan_id", null: false
    t.bigint "match_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fan_id", "match_id"], name: "index_fan_matches_on_fan_id_and_match_id", unique: true
    t.index ["fan_id"], name: "index_fan_matches_on_fan_id"
    t.index ["match_id"], name: "index_fan_matches_on_match_id"
  end

  create_table "fans", force: :cascade do |t|
    t.string "nickname", null: false
    t.integer "ontour_start", default: 0
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((nickname)::text)", name: "index_fans_on_lower_nickname", unique: true
  end

  create_table "match_videos", force: :cascade do |t|
    t.bigint "match_id", null: false
    t.bigint "video_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["match_id"], name: "index_match_videos_on_match_id"
    t.index ["video_id"], name: "index_match_videos_on_video_id", unique: true
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.bigint "tournament_id", null: false
    t.string "stage"
    t.bigint "stadium_id", null: false
    t.datetime "start_at", null: false
    t.bigint "home_team_id", null: false
    t.integer "home_goal"
    t.bigint "visitor_team_id", null: false
    t.integer "visitor_goal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "match_type", null: false
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
    t.index ["season_id"], name: "index_matches_on_season_id"
    t.index ["stadium_id"], name: "index_matches_on_stadium_id"
    t.index ["tournament_id"], name: "index_matches_on_tournament_id"
    t.index ["visitor_team_id"], name: "index_matches_on_visitor_team_id"
  end

  create_table "news_stories", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seasons", force: :cascade do |t|
    t.string "name", null: false
    t.date "start_date", null: false
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stadia", force: :cascade do |t|
    t.string "country"
    t.string "region"
    t.string "district"
    t.integer "loctype", null: false
    t.string "location_name", null: false
    t.string "address"
    t.string "stadium_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((stadium_name)::text), loctype, location_name", name: "index_stadia_on_lower_stadium_name_loctype_location_name", unique: true
  end

  create_table "teams", force: :cascade do |t|
    t.string "team_type"
    t.string "name", null: false
    t.string "location", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text), team_type, location", name: "index_teams_on_lower_name_team_type_location", unique: true
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name", null: false
    t.string "subname"
    t.string "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "role", default: 0
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "name", null: false
    t.string "youtube_id", null: false
    t.integer "video_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["youtube_id"], name: "index_videos_on_youtube_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "fan_matches", "fans"
  add_foreign_key "fan_matches", "matches"
  add_foreign_key "match_videos", "matches"
  add_foreign_key "match_videos", "videos"
  add_foreign_key "matches", "seasons"
  add_foreign_key "matches", "stadia"
  add_foreign_key "matches", "teams", column: "home_team_id"
  add_foreign_key "matches", "teams", column: "visitor_team_id"
  add_foreign_key "matches", "tournaments"
end
