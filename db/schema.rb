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

ActiveRecord::Schema.define(version: 2021_02_14_190624) do

  create_table "glossaries", force: :cascade do |t|
    t.integer "source_language_id", null: false
    t.integer "target_language_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["source_language_id", "target_language_id"], name: "index_glossaries_on_source_language_id_and_target_language_id", unique: true
    t.index ["source_language_id"], name: "index_glossaries_on_source_language_id"
    t.index ["target_language_id"], name: "index_glossaries_on_target_language_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code", null: false
    t.string "country", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "terms", force: :cascade do |t|
    t.string "source", null: false
    t.string "target", null: false
    t.integer "glossary_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["glossary_id"], name: "index_terms_on_glossary_id"
  end

  create_table "translations", force: :cascade do |t|
    t.integer "source_language_id", null: false
    t.integer "target_language_id", null: false
    t.text "source_text", limit: 5000, null: false
    t.integer "glossary_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["glossary_id"], name: "index_translations_on_glossary_id"
    t.index ["source_language_id"], name: "index_translations_on_source_language_id"
    t.index ["target_language_id"], name: "index_translations_on_target_language_id"
  end

  add_foreign_key "glossaries", "languages", column: "source_language_id"
  add_foreign_key "glossaries", "languages", column: "target_language_id"
  add_foreign_key "terms", "glossaries"
  add_foreign_key "translations", "glossaries"
  add_foreign_key "translations", "languages", column: "source_language_id"
  add_foreign_key "translations", "languages", column: "target_language_id"
end
