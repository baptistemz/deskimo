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

ActiveRecord::Schema.define(version: 20160620153523) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "bookings", force: :cascade do |t|
    t.integer  "desk_id"
    t.integer  "user_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "time_slot_quantity"
    t.string   "time_slot_type"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "half_day_choice"
    t.string   "status"
    t.integer  "amount"
    t.integer  "amount_cents",       default: 0,     null: false
    t.json     "payment"
    t.boolean  "archived",           default: false
    t.json     "refund"
  end

  add_index "bookings", ["desk_id"], name: "index_bookings_on_desk_id", using: :btree
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id", using: :btree

  create_table "closing_days", force: :cascade do |t|
    t.date     "date"
    t.integer  "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "closing_days", ["company_id"], name: "index_closing_days_on_company_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "siret"
    t.string   "address"
    t.string   "city"
    t.string   "postcode"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.text     "description"
    t.boolean  "coffee"
    t.boolean  "wifi"
    t.boolean  "printer"
    t.boolean  "scanner"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
    t.boolean  "open_monday",               default: false
    t.boolean  "open_tuesday",              default: false
    t.boolean  "open_wednesday",            default: false
    t.boolean  "open_thursday",             default: false
    t.boolean  "open_friday",               default: false
    t.boolean  "open_saturday",             default: false
    t.boolean  "open_sunday",               default: false
    t.boolean  "open_holiday",              default: false
    t.boolean  "activated",                 default: true
    t.time     "start_time_am"
    t.time     "end_time_am"
    t.time     "start_time_pm"
    t.time     "end_time_pm"
    t.string   "phone_number"
    t.integer  "cheapest_desk_price_cents", default: 0,     null: false
  end

  add_index "companies", ["user_id"], name: "index_companies_on_user_id", using: :btree

  create_table "credit_cards", force: :cascade do |t|
    t.string   "name"
    t.date     "expires_at"
    t.string   "token"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "desks", force: :cascade do |t|
    t.text     "description"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "company_id"
    t.integer  "quantity"
    t.string   "kind"
    t.integer  "hour_price"
    t.integer  "daily_price"
    t.integer  "weekly_price"
    t.boolean  "activated",            default: true
    t.integer  "half_day_price"
    t.integer  "hour_price_cents",     default: 0,     null: false
    t.integer  "half_day_price_cents", default: 0,     null: false
    t.integer  "daily_price_cents",    default: 0,     null: false
    t.integer  "weekly_price_cents",   default: 0,     null: false
    t.integer  "capacity",             default: 1
    t.integer  "number",               default: 1
    t.boolean  "projector",            default: false
    t.boolean  "paperboard"
    t.boolean  "desktop",              default: false
    t.boolean  "tv",                   default: false
    t.boolean  "call_conference",      default: false
    t.string   "calendar_id"
  end

  add_index "desks", ["company_id"], name: "index_desks_on_company_id", using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json     "payment"
    t.integer  "user_id"
    t.json     "refund"
  end

  add_index "invoices", ["booking_id"], name: "index_invoices_on_booking_id", using: :btree
  add_index "invoices", ["user_id"], name: "index_invoices_on_user_id", using: :btree

  create_table "messenger_profiles", force: :cascade do |t|
    t.integer "user_id"
    t.string  "messenger_id"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "profile_pic_url"
    t.string  "locale"
    t.integer "timezone"
    t.string  "gender"
  end

  add_index "messenger_profiles", ["user_id"], name: "index_messenger_profiles_on_user_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "payer_id"
    t.integer  "receiver_id"
    t.integer  "credit_card_id"
    t.json     "response"
    t.string   "status"
    t.string   "mangopay_payin_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "booking_id"
    t.integer  "amount_cents",      default: 0, null: false
  end

  create_table "unavailability_ranges", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "desk_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "kind"
    t.integer  "booking_id"
    t.string   "calendar_event_id"
  end

  add_index "unavailability_ranges", ["booking_id"], name: "index_unavailability_ranges_on_booking_id", using: :btree
  add_index "unavailability_ranges", ["desk_id"], name: "index_unavailability_ranges_on_desk_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "picture"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.string   "stripe_customer_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "google_token"
    t.string   "calendar_access_token"
    t.string   "calendar_refresh_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "welcome_messages", force: :cascade do |t|
    t.text     "message"
    t.string   "wifi_name"
    t.string   "wifi_password"
    t.integer  "company_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.text     "access_information"
    t.text     "additional_information"
  end

  add_index "welcome_messages", ["company_id"], name: "index_welcome_messages_on_company_id", using: :btree

  add_foreign_key "bookings", "desks"
  add_foreign_key "bookings", "users"
  add_foreign_key "closing_days", "companies"
  add_foreign_key "companies", "users"
  add_foreign_key "desks", "companies"
  add_foreign_key "invoices", "bookings"
  add_foreign_key "invoices", "users"
  add_foreign_key "messenger_profiles", "users"
  add_foreign_key "unavailability_ranges", "bookings"
  add_foreign_key "unavailability_ranges", "desks"
  add_foreign_key "welcome_messages", "companies"
end
