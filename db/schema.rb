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

ActiveRecord::Schema.define(:version => 20120416040123) do

  create_table "bills", :force => true do |t|
    t.integer  "vendor_id"
    t.date     "issue_date"
    t.date     "due_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bills", ["vendor_id"], :name => "index_bills_on_vendor_id"

  create_table "payments", :force => true do |t|
    t.integer  "slice_id"
    t.integer  "user_id"
    t.float    "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "payments", ["slice_id"], :name => "index_payments_on_slice_id"
  add_index "payments", ["user_id"], :name => "index_payments_on_user_id"

  create_table "services", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "services_vendors", :force => true do |t|
    t.integer "service_id"
    t.integer "vendor_id"
  end

  create_table "slices", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bill_id"
    t.float    "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "slices", ["bill_id"], :name => "index_slice_on_bill_id"
  add_index "slices", ["user_id"], :name => "index_slice_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.integer  "access_level"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.text     "contact_details"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
