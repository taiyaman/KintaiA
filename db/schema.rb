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

ActiveRecord::Schema.define(version: 20210606113616) do

  create_table "applies", force: :cascade do |t|
    t.date "month"
    t.integer "mark", default: 0, null: false
    t.integer "authorizer"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "authorizer_name"
    t.string "user_name"
    t.boolean "change"
    t.index ["user_id"], name: "index_applies_on_user_id"
  end

  create_table "apps", force: :cascade do |t|
    t.string "Apply"
    t.date "month"
    t.integer "mark"
    t.integer "authorizer"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_apps_on_user_id"
  end

  create_table "attendances", force: :cascade do |t|
    t.date "worked_on"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.string "note"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "scheduled_end_time"
    t.boolean "next_day"
    t.string "business_process"
    t.string "confirmation"
    t.datetime "defalut_work_start_time", default: "2021-06-13 23:30:00"
    t.datetime "defalut_work_end_time", default: "2021-06-14 08:30:00"
    t.boolean "change"
    t.string "overtime_status"
    t.string "change2"
    t.datetime "before_started_at"
    t.datetime "before_finished_at"
    t.datetime "changed_started_at"
    t.datetime "changed_finished_at"
    t.string "confirmation_change"
    t.integer "confirmation_id"
    t.string "confirmation_change_status"
    t.boolean "change_attendance"
    t.integer "confirmation_id_zangyou"
    t.boolean "next_day2"
    t.index ["user_id"], name: "index_attendances_on_user_id"
  end

  create_table "bases", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "base_id"
    t.string "attendance"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "department"
    t.datetime "basic_time", default: "2021-06-13 23:00:00"
    t.datetime "work_time", default: "2021-06-13 22:30:00"
    t.integer "employees_number"
    t.integer "uid"
    t.datetime "work_start_time"
    t.datetime "work_end_time"
    t.boolean "superior"
    t.datetime "defalut_work_start_time", default: "2021-06-13 23:30:00"
    t.datetime "defalut_work_end_time", default: "2021-06-14 08:30:00"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
