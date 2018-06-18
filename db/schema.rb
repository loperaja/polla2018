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

ActiveRecord::Schema.define(version: 2018_06_18_103708) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chats", force: :cascade do |t|
    t.string "author"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer "home_team_id"
    t.integer "index"
    t.integer "away_team_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "added"
    t.datetime "date"
    t.index ["away_team_id"], name: "index_matches_on_away_team_id"
    t.index ["home_team_id"], name: "index_matches_on_home_team_id"
  end

  create_table "point_histories", force: :cascade do |t|
    t.integer "polla_id"
    t.integer "result_id"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "points_awarded"
    t.index ["polla_id"], name: "index_point_histories_on_polla_id"
    t.index ["result_id"], name: "index_point_histories_on_result_id"
  end

  create_table "pollas", force: :cascade do |t|
    t.string "name"
    t.integer "user_id"
    t.integer "points", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "wizard_step", default: 0
    t.integer "last_step", default: 1
    t.boolean "paid"
    t.boolean "real", default: false
    t.index ["user_id"], name: "index_pollas_on_user_id"
  end

  create_table "results", force: :cascade do |t|
    t.string "index"
    t.integer "result"
    t.integer "resultable_id"
    t.string "resultable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "polla_id"
    t.boolean "added", default: false
    t.index ["polla_id"], name: "index_results_on_polla_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "name"
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "num_teams"
    t.string "step"
    t.boolean "added"
    t.datetime "date"
    t.index ["step"], name: "index_rounds_on_step"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "group"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer "points"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
