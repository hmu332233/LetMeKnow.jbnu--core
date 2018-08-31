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

ActiveRecord::Schema.define(version: 20180907171428) do

  create_table "dormitory_menu_dbs", force: :cascade do |t|
    t.string   "key_name"
    t.string   "date"
    t.string   "menus_string"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "majors", force: :cascade do |t|
    t.string   "name"
    t.string   "office",     default: "x"
    t.string   "tel",        default: "x"
    t.string   "fax",        default: "x"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "keyword"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sws", force: :cascade do |t|
    t.integer  "menu",       default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "user_words", force: :cascade do |t|
    t.string   "user_key"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
