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

ActiveRecord::Schema.define(version: 20170430124356) do

  create_table "db_menu_domitories", force: :cascade do |t|
    t.string   "week"
    t.string   "breakfast"
    t.string   "lunch"
    t.string   "dinner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hits", force: :cascade do |t|
    t.string   "name"
    t.integer  "connect_hits", default: 0
    t.integer  "all_hits",     default: 0
    t.integer  "help_hits",    default: 0
    t.integer  "notice_hits",  default: 0
    t.integer  "domi_hits",    default: 0
    t.integer  "office_hits",  default: 0
    t.integer  "chik_hits",    default: 0
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
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

  create_table "words", force: :cascade do |t|
    t.string   "content"
    t.integer  "count",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
