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

ActiveRecord::Schema.define(version: 20140113044034) do

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

end
