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

ActiveRecord::Schema.define(version: 2020_04_16_162520) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "disposable_tokens", force: :cascade do |t|
    t.string "value", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at"], name: "index_disposable_tokens_on_expires_at"
    t.index ["value", "expires_at"], name: "index_disposable_tokens_on_value_and_expires_at"
    t.index ["value"], name: "index_disposable_tokens_on_value"
  end

  create_table "task_list_users", force: :cascade do |t|
    t.integer "task_list_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_list_id", "user_id"], name: "index_task_list_users_on_task_list_id_and_user_id", unique: true
  end

  create_table "task_lists", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "list_position", default: 0
    t.index ["list_position"], name: "index_task_lists_on_list_position"
    t.index ["name"], name: "index_task_lists_on_name"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "task_list_id", null: false
    t.string "content", null: false
    t.integer "list_position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "happens_at"
    t.datetime "completed_at"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.index ["completed_at"], name: "index_tasks_on_completed_at"
    t.index ["latitude", "longitude"], name: "index_tasks_on_latitude_and_longitude"
    t.index ["list_position"], name: "index_tasks_on_list_position"
    t.index ["task_list_id"], name: "index_tasks_on_task_list_id"
  end

  create_table "user_devices", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "fcm_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fcm_token"], name: "index_user_devices_on_fcm_token"
    t.index ["user_id", "fcm_token"], name: "index_user_devices_on_user_id_and_fcm_token", unique: true
    t.index ["user_id"], name: "index_user_devices_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

end
