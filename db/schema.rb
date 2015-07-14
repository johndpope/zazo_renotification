# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150711085725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conditions", force: :cascade do |t|
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "program_id"
  end

  add_index "conditions", ["program_id"], name: "index_conditions_on_program_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "target"
    t.text     "title"
    t.text     "body"
    t.datetime "send_at"
    t.string   "status"
    t.integer  "program_id"
    t.integer  "sequence_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "messages", ["program_id"], name: "index_messages_on_program_id", using: :btree
  add_index "messages", ["sequence_id"], name: "index_messages_on_sequence_id", using: :btree

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "programs", ["deleted_at"], name: "index_programs_on_deleted_at", using: :btree

  create_table "queries", force: :cascade do |t|
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "program_id"
  end

  add_index "queries", ["program_id"], name: "index_queries_on_program_id", using: :btree

  create_table "sequences", force: :cascade do |t|
    t.integer  "template_id"
    t.float    "delay_hours"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "program_id"
  end

  add_index "sequences", ["program_id"], name: "index_sequences_on_program_id", using: :btree
  add_index "sequences", ["template_id"], name: "index_sequences_on_template_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.boolean  "started"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "program_id"
  end

  add_index "settings", ["program_id"], name: "index_settings_on_program_id", using: :btree

  create_table "templates", force: :cascade do |t|
    t.string   "kind"
    t.string   "name"
    t.text     "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  add_index "templates", ["deleted_at"], name: "index_templates_on_deleted_at", using: :btree
  add_index "templates", ["name"], name: "index_templates_on_name", unique: true, using: :btree

  add_foreign_key "conditions", "programs"
  add_foreign_key "messages", "programs"
  add_foreign_key "messages", "sequences"
  add_foreign_key "queries", "programs"
  add_foreign_key "sequences", "programs"
  add_foreign_key "sequences", "templates"
  add_foreign_key "settings", "programs"
end
