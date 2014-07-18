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

ActiveRecord::Schema.define(version: 20140714200444) do

  create_table "jobs", force: true do |t|
    t.string   "employer_id"
    t.string   "title"
    t.string   "job_description"
    t.string   "category"
    t.string   "location"
    t.integer  "vacancies"
    t.string   "company"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.datetime "deadline"
    t.string   "job_type"
    t.integer  "experience"
    t.string   "qualification"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "min_age"
    t.string   "max_age"
    t.text     "requirements"
  end

  create_table "jobseekers", force: true do |t|
    t.integer  "user_id"
    t.date     "dob"
    t.string   "sex"
    t.string   "location"
    t.string   "phone"
    t.string   "qualification"
    t.string   "experience"
    t.string   "field"
    t.string   "cv_type"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "jobseekers", ["user_id"], name: "index_jobseekers_on_user_id"

  create_table "microposts", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id"

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin"
    t.string   "password_reset_token"
    t.datetime "password_sent_at"
    t.string   "role"
    t.string   "last_name"
  end

end
