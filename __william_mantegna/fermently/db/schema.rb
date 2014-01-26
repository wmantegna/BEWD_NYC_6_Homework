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

ActiveRecord::Schema.define(version: 20140124221941) do

  create_table "beer_styles", force: true do |t|
    t.string   "name"
    t.string   "category"
    t.string   "description"
    t.float    "abvMin"
    t.float    "abvMax"
    t.float    "ibuMin"
    t.float    "ibuMax"
    t.float    "ogMin"
    t.float    "ogMax"
    t.float    "fgMin"
    t.float    "fgMax"
    t.float    "srmMin"
    t.float    "srmMax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "beers", force: true do |t|
    t.string   "name"
    t.integer  "beer_style_id"
    t.float    "og"
    t.float    "fg"
    t.float    "abv"
    t.datetime "dateBrewed"
    t.datetime "dateBottled"
    t.string   "priming"
    t.string   "recipe"
    t.float    "rating"
    t.text     "brewerComment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
