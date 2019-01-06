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

ActiveRecord::Schema.define(version: 20190106144938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gminy", force: :cascade do |t|
    t.string   "name"
    t.string   "name_dod"
    t.string   "teryt"
    t.integer  "wojewodztwo_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.date     "stan_na",        default: '2019-01-01'
    t.index ["wojewodztwo_id"], name: "index_gminy_on_wojewodztwo_id", using: :btree
  end

  create_table "gminy_plynne", id: false, force: :cascade do |t|
    t.integer "gmina_id",  null: false
    t.integer "plynny_id", null: false
  end

  create_table "gminy_stale", id: false, force: :cascade do |t|
    t.integer "gmina_id", null: false
    t.integer "staly_id", null: false
  end

  create_table "grunty", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "grunty_plynne", id: false, force: :cascade do |t|
    t.integer "grunt_id",  null: false
    t.integer "plynny_id", null: false
  end

  create_table "grunty_stale", id: false, force: :cascade do |t|
    t.integer "grunt_id", null: false
    t.integer "staly_id", null: false
  end

  create_table "plynne", force: :cascade do |t|
    t.date     "od"
    t.date     "do"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stale", force: :cascade do |t|
    t.date     "od"
    t.date     "do"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wojewodztwa", force: :cascade do |t|
    t.string   "name"
    t.string   "teryt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "gminy", "wojewodztwa"
end
