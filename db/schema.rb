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

ActiveRecord::Schema.define(version: 2021_07_16_165041) do

  create_table "calls", force: :cascade do |t|
    t.integer "contract_id"
    t.string "from", limit: 255, null: false
    t.string "to", limit: 255, null: false
    t.integer "duration", null: false
    t.integer "direction", limit: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_calls_on_contract_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "plan_id"
    t.string "name", limit: 255, null: false
    t.integer "users_quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["plan_id"], name: "index_contracts_on_plan_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.integer "price", null: false
  end

end
