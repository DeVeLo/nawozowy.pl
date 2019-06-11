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

ActiveRecord::Schema.define(version: 20190611090802) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "animalgroups", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.uuid     "instytucja_id"
    t.uuid     "rolnik_id"
    t.uuid     "zlecenie_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["instytucja_id"], name: "index_animalgroups_on_instytucja_id", using: :btree
    t.index ["rolnik_id"], name: "index_animalgroups_on_rolnik_id", using: :btree
    t.index ["zlecenie_id"], name: "index_animalgroups_on_zlecenie_id", using: :btree
  end

  create_table "animals", force: :cascade do |t|
    t.uuid     "instytucja_id"
    t.uuid     "rolnik_id"
    t.uuid     "zlecenie_id"
    t.integer  "zwierze_id"
    t.integer  "nazwautrzymania_id"
    t.integer  "systemutrzymania_id"
    t.decimal  "sztuk"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "specjalnezywienie",   default: false
    t.boolean  "badania",             default: false
    t.decimal  "zawartosc"
    t.integer  "rownowaznik_id"
    t.uuid     "animalgroup_id"
    t.decimal  "fosfor"
    t.decimal  "potas"
    t.decimal  "magnez"
    t.decimal  "wapn"
    t.boolean  "zrodlo",              default: false, null: false
    t.decimal  "tony",                default: "0.0", null: false
    t.index ["animalgroup_id"], name: "index_animals_on_animalgroup_id", using: :btree
    t.index ["instytucja_id"], name: "index_animals_on_instytucja_id", using: :btree
    t.index ["nazwautrzymania_id"], name: "index_animals_on_nazwautrzymania_id", using: :btree
    t.index ["rolnik_id"], name: "index_animals_on_rolnik_id", using: :btree
    t.index ["rownowaznik_id"], name: "index_animals_on_rownowaznik_id", using: :btree
    t.index ["systemutrzymania_id"], name: "index_animals_on_systemutrzymania_id", using: :btree
    t.index ["zlecenie_id"], name: "index_animals_on_zlecenie_id", using: :btree
    t.index ["zwierze_id"], name: "index_animals_on_zwierze_id", using: :btree
  end

  create_table "bobowate", force: :cascade do |t|
    t.string   "name"
    t.decimal  "n"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dawkicao", force: :cascade do |t|
    t.integer  "kategoria_id"
    t.integer  "grunt_id"
    t.decimal  "od"
    t.decimal  "do"
    t.decimal  "dawka"
    t.integer  "potrzeba_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "sad",          default: false
    t.index ["grunt_id"], name: "index_dawkicao_on_grunt_id", using: :btree
    t.index ["kategoria_id"], name: "index_dawkicao_on_kategoria_id", using: :btree
    t.index ["potrzeba_id"], name: "index_dawkicao_on_potrzeba_id", using: :btree
  end

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
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "tel"
    t.string   "fax"
    t.string   "mail"
    t.string   "miejscowosc"
    t.string   "kod"
    t.string   "poczta"
    t.string   "www",            default: ""
    t.string   "shortname",      default: ""
    t.string   "logo",           default: ""
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
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.decimal  "przelicznik"
  end

  create_table "nawozynaturalne", force: :cascade do |t|
    t.integer  "uzytek_id"
    t.integer  "animal_id"
    t.integer  "sezon_id"
    t.decimal  "produkcja"
    t.decimal  "n"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.decimal  "ilosc"
    t.uuid     "animalgroup_id"
    t.integer  "sposob",         default: 1
    t.index ["animal_id"], name: "index_nawozynaturalne_on_animal_id", using: :btree
    t.index ["animalgroup_id"], name: "index_nawozynaturalne_on_animalgroup_id", using: :btree
    t.index ["sezon_id"], name: "index_nawozynaturalne_on_sezon_id", using: :btree
    t.index ["uzytek_id"], name: "index_nawozynaturalne_on_uzytek_id", using: :btree
  end

  create_table "nawozywykorzystane", force: :cascade do |t|
    t.integer  "animal_id"
    t.integer  "nawoznaturalny_id"
    t.decimal  "ilosc"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.decimal  "ilosc_na_pole"
    t.index ["animal_id"], name: "index_nawozywykorzystane_on_animal_id", using: :btree
    t.index ["nawoznaturalny_id"], name: "index_nawozywykorzystane_on_nawoznaturalny_id", using: :btree
  end

  create_table "nazwyutrzymania", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "wspwykorzystania_id"
    t.string   "sname"
    t.index ["wspwykorzystania_id"], name: "index_nazwyutrzymania_on_wspwykorzystania_id", using: :btree
  end

  create_table "ocenapota", force: :cascade do |t|
    t.integer  "ocena_id"
    t.integer  "kategoria_id"
    t.decimal  "powyzej"
    t.decimal  "ponizej"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["kategoria_id"], name: "index_ocenapota_on_kategoria_id", using: :btree
    t.index ["ocena_id"], name: "index_ocenapota_on_ocena_id", using: :btree
  end

  create_table "oceny", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.decimal  "wspolczynnik"
  end

  create_table "ocenyfosfor", force: :cascade do |t|
    t.integer  "kategoria_id"
    t.integer  "ocena_id"
    t.boolean  "weglanowa"
    t.decimal  "powyzej"
    t.decimal  "ponizej"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "sad",          default: false
    t.index ["kategoria_id"], name: "index_ocenyfosfor_on_kategoria_id", using: :btree
    t.index ["ocena_id"], name: "index_ocenyfosfor_on_ocena_id", using: :btree
  end

  create_table "ocenymagnez", force: :cascade do |t|
    t.integer  "ocena_id"
    t.integer  "kategoria_id"
    t.decimal  "powyzej"
    t.decimal  "ponizej"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "rownowaznik"
    t.boolean  "sad",          default: false
    t.decimal  "korektatyton", default: "0.0"
    t.index ["kategoria_id"], name: "index_ocenymagnez_on_kategoria_id", using: :btree
    t.index ["ocena_id"], name: "index_ocenymagnez_on_ocena_id", using: :btree
  end

  create_table "ocenypotas", force: :cascade do |t|
    t.integer  "ocena_id"
    t.integer  "kategoria_id"
    t.decimal  "powyzej"
    t.decimal  "ponizej"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "sad",          default: false
    t.index ["kategoria_id"], name: "index_ocenypotas_on_kategoria_id", using: :btree
    t.index ["ocena_id"], name: "index_ocenypotas_on_ocena_id", using: :btree
  end

  create_table "phzakresy", force: :cascade do |t|
    t.string   "name"
    t.string   "odczyn"
    t.decimal  "od"
    t.decimal  "do"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plynne", force: :cascade do |t|
    t.date     "od"
    t.date     "do"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "podstawy", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "potrzeby", force: :cascade do |t|
    t.string   "name"
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

  create_table "rolnicy", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.string   "lname"
    t.string   "gname"
    t.integer  "wojewodztwo_id"
    t.integer  "powiat_id"
    t.integer  "gmina_id"
    t.string   "miejscowosc"
    t.string   "nrdom"
    t.string   "nrmieszkania"
    t.string   "nip"
    t.string   "nig"
    t.string   "ulica"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.uuid     "instytucja_id"
    t.string   "kod"
    t.string   "poczta"
    t.string   "tel"
    t.string   "kom"
    t.string   "mail"
    t.text     "keywords",       default: "", null: false
    t.index ["gmina_id"], name: "index_rolnicy_on_gmina_id", using: :btree
    t.index ["instytucja_id"], name: "index_rolnicy_on_instytucja_id", using: :btree
    t.index ["powiat_id"], name: "index_rolnicy_on_powiat_id", using: :btree
    t.index ["wojewodztwo_id"], name: "index_rolnicy_on_wojewodztwo_id", using: :btree
  end

  create_table "roslinaprzedplony", force: :cascade do |t|
    t.string   "name"
    t.decimal  "n"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.decimal  "fosfor"
    t.decimal  "potas"
    t.decimal  "mnoznik"
    t.decimal  "wsp_fosfor_i_rok"
    t.decimal  "wsp_potas_i_rok"
    t.decimal  "wsp_magnez_i_rok"
    t.decimal  "wsp_fosfor_ii_rok"
    t.decimal  "wsp_potas_ii_rok"
    t.decimal  "wsp_magnez_ii_rok"
  end

  create_table "rosliny", force: :cascade do |t|
    t.string   "name"
    t.decimal  "pobranie"
    t.integer  "rodzajuprawy_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.decimal  "wspolczynnik",    default: "0.6"
    t.decimal  "fosfor"
    t.decimal  "potas"
    t.decimal  "magnez"
    t.boolean  "sad",             default: false
    t.boolean  "tyton",           default: false
    t.string   "extname",         default: ""
    t.boolean  "sloma",           default: false, null: false
    t.index ["rodzajuprawy_id"], name: "index_rosliny_on_rodzajuprawy_id", using: :btree
  end

  create_table "rownowazniki", force: :cascade do |t|
    t.integer  "gatunek_id"
    t.integer  "nazwautrzymania_id"
    t.integer  "sezon_id"
    t.decimal  "wartosc"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "wariant"
    t.integer  "zwierze_id"
    t.decimal  "jesien"
    t.decimal  "wiosna"
    t.index ["gatunek_id"], name: "index_rownowazniki_on_gatunek_id", using: :btree
    t.index ["nazwautrzymania_id"], name: "index_rownowazniki_on_nazwautrzymania_id", using: :btree
    t.index ["sezon_id"], name: "index_rownowazniki_on_sezon_id", using: :btree
    t.index ["zwierze_id"], name: "index_rownowazniki_on_zwierze_id", using: :btree
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

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "lname"
    t.uuid     "instytucja_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "role"
    t.string   "szukajrolnika",          default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["instytucja_id"], name: "index_users_on_instytucja_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "uzytki", force: :cascade do |t|
    t.string   "name"
    t.integer  "kategoria_id"
    t.integer  "rodzajuprawy_id"
    t.decimal  "nmin"
    t.decimal  "prognoza"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.uuid     "instytucja_id"
    t.uuid     "rolnik_id"
    t.uuid     "zlecenie_id"
    t.boolean  "badania",             default: false
    t.integer  "bobowate_id"
    t.integer  "roslina_id"
    t.decimal  "plon"
    t.decimal  "powierzchnia"
    t.boolean  "nminsezon",           default: false
    t.decimal  "przedplon",           default: "0.0"
    t.integer  "roslinaprzedplon_id", default: 1
    t.integer  "bobowata_id"
    t.integer  "grunt_id"
    t.decimal  "ph"
    t.boolean  "weglanowa",           default: false
    t.decimal  "fosfor"
    t.decimal  "potas"
    t.decimal  "magnez"
    t.decimal  "przedplonfosfor",     default: "0.0"
    t.decimal  "przedplonpotas",      default: "0.0"
    t.integer  "wspwykorzystania_id"
    t.decimal  "plonprzedplonowej"
    t.integer  "lp"
    t.boolean  "stanprzedplonu",      default: true,  null: false
    t.decimal  "korekta_azot"
    t.decimal  "korekta_fosfor"
    t.decimal  "korekta_potas"
    t.decimal  "korekta_magnez"
    t.decimal  "korekta_wapn"
    t.boolean  "sloma_zebrana",       default: false, null: false
    t.index ["bobowata_id"], name: "index_uzytki_on_bobowata_id", using: :btree
    t.index ["bobowate_id"], name: "index_uzytki_on_bobowate_id", using: :btree
    t.index ["grunt_id"], name: "index_uzytki_on_grunt_id", using: :btree
    t.index ["instytucja_id"], name: "index_uzytki_on_instytucja_id", using: :btree
    t.index ["kategoria_id"], name: "index_uzytki_on_kategoria_id", using: :btree
    t.index ["rodzajuprawy_id"], name: "index_uzytki_on_rodzajuprawy_id", using: :btree
    t.index ["rolnik_id"], name: "index_uzytki_on_rolnik_id", using: :btree
    t.index ["roslina_id"], name: "index_uzytki_on_roslina_id", using: :btree
    t.index ["roslinaprzedplon_id"], name: "index_uzytki_on_roslinaprzedplon_id", using: :btree
    t.index ["wspwykorzystania_id"], name: "index_uzytki_on_wspwykorzystania_id", using: :btree
    t.index ["zlecenie_id"], name: "index_uzytki_on_zlecenie_id", using: :btree
  end

  create_table "warianty", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wojewodztwa", force: :cascade do |t|
    t.string   "name"
    t.string   "teryt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "stanna"
  end

  create_table "wspiwykorzystania", force: :cascade do |t|
    t.string   "name"
    t.decimal  "wsp_fosfor_i_rok"
    t.decimal  "wsp_potas_i_rok"
    t.decimal  "wsp_magnez_i_rok"
    t.decimal  "wsp_fosfor_ii_rok"
    t.decimal  "wsp_potas_ii_rok"
    t.decimal  "wsp_magnez_ii_rok"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "zlecenia", id: :uuid, default: -> { "uuid_generate_v4()" }, force: :cascade do |t|
    t.string   "name"
    t.uuid     "instytucja_id"
    t.uuid     "rolnik_id"
    t.integer  "wariant_id"
    t.string   "podstawainna"
    t.string   "sprawa"
    t.integer  "podstawa_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "wojewodztwo_id"
    t.integer  "powiat_id"
    t.integer  "gmina_id"
    t.string   "miejscowosc"
    t.string   "powierzchnia"
    t.date     "datawplywu"
    t.integer  "lp"
    t.integer  "rejestr"
    t.boolean  "typ",              default: false, null: false
    t.boolean  "bilansn",          default: false
    t.date     "datawydruku"
    t.boolean  "zmiendatewydruku", default: false
    t.text     "uwagi",            default: ""
    t.uuid     "parent_id"
    t.index ["gmina_id"], name: "index_zlecenia_on_gmina_id", using: :btree
    t.index ["instytucja_id"], name: "index_zlecenia_on_instytucja_id", using: :btree
    t.index ["parent_id"], name: "index_zlecenia_on_parent_id", using: :btree
    t.index ["podstawa_id"], name: "index_zlecenia_on_podstawa_id", using: :btree
    t.index ["powiat_id"], name: "index_zlecenia_on_powiat_id", using: :btree
    t.index ["rolnik_id"], name: "index_zlecenia_on_rolnik_id", using: :btree
    t.index ["wariant_id"], name: "index_zlecenia_on_wariant_id", using: :btree
    t.index ["wojewodztwo_id"], name: "index_zlecenia_on_wojewodztwo_id", using: :btree
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

  add_foreign_key "animalgroups", "instytucje"
  add_foreign_key "animalgroups", "rolnicy"
  add_foreign_key "animalgroups", "zlecenia"
  add_foreign_key "animals", "animalgroups"
  add_foreign_key "animals", "instytucje"
  add_foreign_key "animals", "nazwyutrzymania"
  add_foreign_key "animals", "rolnicy"
  add_foreign_key "animals", "rownowazniki"
  add_foreign_key "animals", "systemyutrzymania"
  add_foreign_key "animals", "zlecenia"
  add_foreign_key "animals", "zwierzeta"
  add_foreign_key "dawkicao", "grunty"
  add_foreign_key "dawkicao", "kategorie"
  add_foreign_key "dawkicao", "potrzeby"
  add_foreign_key "gminy", "powiaty"
  add_foreign_key "gminy", "wojewodztwa"
  add_foreign_key "instytucje", "gminy"
  add_foreign_key "instytucje", "powiaty"
  add_foreign_key "instytucje", "wojewodztwa"
  add_foreign_key "nawozynaturalne", "animalgroups"
  add_foreign_key "nawozynaturalne", "animals"
  add_foreign_key "nawozynaturalne", "sezony"
  add_foreign_key "nawozynaturalne", "uzytki"
  add_foreign_key "nawozywykorzystane", "animals"
  add_foreign_key "nawozywykorzystane", "nawozynaturalne"
  add_foreign_key "nazwyutrzymania", "wspiwykorzystania"
  add_foreign_key "ocenapota", "kategorie"
  add_foreign_key "ocenapota", "oceny"
  add_foreign_key "ocenyfosfor", "kategorie"
  add_foreign_key "ocenyfosfor", "oceny"
  add_foreign_key "ocenymagnez", "kategorie"
  add_foreign_key "ocenymagnez", "oceny"
  add_foreign_key "ocenypotas", "kategorie"
  add_foreign_key "ocenypotas", "oceny"
  add_foreign_key "powiaty", "wojewodztwa"
  add_foreign_key "rolnicy", "gminy"
  add_foreign_key "rolnicy", "instytucje"
  add_foreign_key "rolnicy", "powiaty"
  add_foreign_key "rolnicy", "wojewodztwa"
  add_foreign_key "rosliny", "rodzajeupraw"
  add_foreign_key "rownowazniki", "gatunki"
  add_foreign_key "rownowazniki", "nazwyutrzymania"
  add_foreign_key "rownowazniki", "sezony"
  add_foreign_key "rownowazniki", "zwierzeta"
  add_foreign_key "systemyutrzymania", "jednostkiutrzymania"
  add_foreign_key "systemyutrzymania", "nazwyutrzymania"
  add_foreign_key "systemyutrzymania", "zwierzeta"
  add_foreign_key "users", "instytucje"
  add_foreign_key "uzytki", "bobowate"
  add_foreign_key "uzytki", "bobowate", column: "bobowate_id"
  add_foreign_key "uzytki", "grunty"
  add_foreign_key "uzytki", "instytucje"
  add_foreign_key "uzytki", "kategorie"
  add_foreign_key "uzytki", "rodzajeupraw"
  add_foreign_key "uzytki", "rolnicy"
  add_foreign_key "uzytki", "roslinaprzedplony"
  add_foreign_key "uzytki", "rosliny"
  add_foreign_key "uzytki", "wspiwykorzystania"
  add_foreign_key "uzytki", "zlecenia"
  add_foreign_key "zlecenia", "gminy"
  add_foreign_key "zlecenia", "instytucje"
  add_foreign_key "zlecenia", "podstawy"
  add_foreign_key "zlecenia", "powiaty"
  add_foreign_key "zlecenia", "rolnicy"
  add_foreign_key "zlecenia", "warianty"
  add_foreign_key "zlecenia", "wojewodztwa"
  add_foreign_key "zlecenia", "zlecenia", column: "parent_id"
  add_foreign_key "zwierzeta", "gatunki"
end
