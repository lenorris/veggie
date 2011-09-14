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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110911100706) do

  create_table "branches", :force => true do |t|
    t.integer  "restaurant_id"
    t.string   "street_address"
    t.string   "city"
    t.string   "phone"
    t.string   "business_hours"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "branches", ["restaurant_id"], :name => "index_branches_on_restaurant_id"

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.string   "website"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
