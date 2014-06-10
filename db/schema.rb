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

ActiveRecord::Schema.define(version: 20140530034810) do

  create_table "devices", force: true do |t|
    t.string   "uuid",       null: false
    t.string   "token"
    t.string   "os"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devices", ["uuid"], name: "index_devices_on_uuid", unique: true

  create_table "events", force: true do |t|
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedule_actors", force: true do |t|
    t.integer  "user_id"
    t.integer  "schedule_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.integer  "user_id"
    t.string   "guid",                       null: false
    t.string   "title"
    t.string   "image"
    t.text     "description"
    t.datetime "start_datetime"
    t.datetime "end_datetime"
    t.boolean  "all_day"
    t.string   "place"
    t.string   "latitude"
    t.string   "longitude"
    t.integer  "lock_version",   default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["guid"], name: "index_schedules_on_guid", unique: true

  create_table "shared_event_actors", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "nickname"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
