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

ActiveRecord::Schema[7.1].define(version: 2023_11_11_210655) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "metal_mine_upgrades", force: :cascade do |t|
    t.bigint "planet_id", null: false
    t.integer "target_level", null: false
    t.datetime "ends_at", null: false
    t.boolean "finished", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planet_id"], name: "index_metal_mine_upgrades_on_planet_id"
  end

  create_table "planets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "metal", default: 0, null: false
    t.datetime "resources_updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "metal_mine_level", default: 1, null: false
    t.integer "metal_basic_income", default: 1, null: false
    t.index ["user_id"], name: "index_planets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
  end

  add_foreign_key "metal_mine_upgrades", "planets"
  add_foreign_key "planets", "users"
end
