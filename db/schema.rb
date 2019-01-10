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

ActiveRecord::Schema.define(version: 20190110122011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "gatunki", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gminy", force: :cascade do |t|
    t.string   "name"
    t.string   "name_dod"
    t.string   "teryt"
    t.integer  "wojewodztwo_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "powiat_id"
    t.date     "stanna"
    t.index ["powiat_id"], name: "index_gminy_on_powiat_id", using: :btree
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

  create_table "instytucje", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "nip"
    t.string   "regon"
    t.integer  "wojewodztwo_id"
    t.integer  "powiat_id"
    t.integer  "gmina_id"
    t.string   "ulica"
    t.string   "nrp"
    t.string   "nrm"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["gmina_id"], name: "index_instytucje_on_gmina_id", using: :btree
    t.index ["powiat_id"], name: "index_instytucje_on_powiat_id", using: :btree
    t.index ["wojewodztwo_id"], name: "index_instytucje_on_wojewodztwo_id", using: :btree
  end

  create_table "jednostkiutrzymania", force: :cascade do |t|
    t.string   "produkcja"
    t.string   "zawartosc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "kategorie", force: :cascade do |t|
    t.string   "name"
    t.decimal  "zasob"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nazwyutrzymania", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plynne", force: :cascade do |t|
    t.date     "od"
    t.date     "do"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "powiaty", force: :cascade do |t|
    t.string   "name"
    t.string   "teryt"
    t.integer  "wojewodztwo_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.date     "stanna"
    t.index ["wojewodztwo_id"], name: "index_powiaty_on_wojewodztwo_id", using: :btree
  end

  create_table "rodzajeupraw", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rolnicy", force: :cascade do |t|
    t.string   "name"
    t.string   "lname"
    t.string   "gname"
    t.integer  "wojewodztwo_id"
    t.integer  "powiat_id"
    t.integer  "gmina_id"
    t.string   "miejscowosc"
    t.string   "nrdom"
    t.string   "nrmieszkania"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "nip"
    t.string   "nig"
    t.string   "ulica"
    t.uuid     "instytucja_id"
    t.index ["gmina_id"], name: "index_rolnicy_on_gmina_id", using: :btree
    t.index ["instytucja_id"], name: "index_rolnicy_on_instytucja_id", using: :btree
    t.index ["powiat_id"], name: "index_rolnicy_on_powiat_id", using: :btree
    t.index ["wojewodztwo_id"], name: "index_rolnicy_on_wojewodztwo_id", using: :btree
  end

  create_table "rosliny", force: :cascade do |t|
    t.string   "name"
    t.decimal  "pobranie"
    t.integer  "rodzajuprawy_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["rodzajuprawy_id"], name: "index_rosliny_on_rodzajuprawy_id", using: :btree
  end

  create_table "rownowazniki", force: :cascade do |t|
    t.integer  "gatunek_id"
    t.integer  "nazwautrzymania_id"
    t.integer  "sezon_id"
    t.decimal  "wartosc"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["gatunek_id"], name: "index_rownowazniki_on_gatunek_id", using: :btree
    t.index ["nazwautrzymania_id"], name: "index_rownowazniki_on_nazwautrzymania_id", using: :btree
    t.index ["sezon_id"], name: "index_rownowazniki_on_sezon_id", using: :btree
  end

  create_table "sezony", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stale", force: :cascade do |t|
    t.date     "od"
    t.date     "do"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "systemyutrzymania", force: :cascade do |t|
    t.decimal  "produkcja"
    t.decimal  "zawartosc"
    t.integer  "jednostkautrzymania_id"
    t.integer  "nazwautrzymania_id"
    t.integer  "zwierze_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["jednostkautrzymania_id"], name: "index_systemyutrzymania_on_jednostkautrzymania_id", using: :btree
    t.index ["nazwautrzymania_id"], name: "index_systemyutrzymania_on_nazwautrzymania_id", using: :btree
    t.index ["zwierze_id"], name: "index_systemyutrzymania_on_zwierze_id", using: :btree
  end

  create_table "wojewodztwa", force: :cascade do |t|
    t.string   "name"
    t.string   "teryt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "stanna"
  end

  create_table "zwierzeta", force: :cascade do |t|
    t.string   "name"
    t.integer  "gatunek_id"
    t.decimal  "wspolczynnik"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.decimal  "koncentracja"
    t.index ["gatunek_id"], name: "index_zwierzeta_on_gatunek_id", using: :btree
  end

  add_foreign_key "gminy", "powiaty"
  add_foreign_key "gminy", "wojewodztwa"
  add_foreign_key "instytucje", "gminy"
  add_foreign_key "instytucje", "powiaty"
  add_foreign_key "instytucje", "wojewodztwa"
  add_foreign_key "powiaty", "wojewodztwa"
  add_foreign_key "rolnicy", "gminy"
  add_foreign_key "rolnicy", "instytucje"
  add_foreign_key "rolnicy", "powiaty"
  add_foreign_key "rolnicy", "wojewodztwa"
  add_foreign_key "rosliny", "rodzajeupraw"
  add_foreign_key "rownowazniki", "gatunki"
  add_foreign_key "rownowazniki", "nazwyutrzymania"
  add_foreign_key "rownowazniki", "sezony"
  add_foreign_key "systemyutrzymania", "jednostkiutrzymania"
  add_foreign_key "systemyutrzymania", "nazwyutrzymania"
  add_foreign_key "systemyutrzymania", "zwierzeta"
  add_foreign_key "zwierzeta", "gatunki"
end
