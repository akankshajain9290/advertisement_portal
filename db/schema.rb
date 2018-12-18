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

ActiveRecord::Schema.define(version: 5) do

  create_table "adv_spaces", force: :cascade do |t|
    t.string "name"
    t.integer "provider_id"
    t.index ["provider_id"], name: "index_adv_spaces_on_provider_id"
  end

  create_table "bids", force: :cascade do |t|
    t.float "price"
    t.integer "organiser_id"
    t.integer "slot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organiser_id"], name: "index_bids_on_organiser_id"
    t.index ["slot_id"], name: "index_bids_on_slot_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slots", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.float "price"
    t.string "status"
    t.integer "agent_id"
    t.integer "organiser_id"
    t.integer "adv_space_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["adv_space_id"], name: "index_slots_on_adv_space_id"
    t.index ["agent_id"], name: "index_slots_on_agent_id"
    t.index ["organiser_id"], name: "index_slots_on_organiser_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "encrypted_password"
    t.string "first_name"
    t.string "last_name"
    t.string "organisation"
    t.integer "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_users_on_role_id"
  end

end
