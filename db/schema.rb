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

ActiveRecord::Schema.define(version: 20150328145417) do

  create_table "categories", force: :cascade do |t|
    t.string   "name_nl",    limit: 255
    t.string   "name_en",    limit: 255
    t.boolean  "enabled",    limit: 1,   default: true, null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.text     "content_md",   limit: 65535
    t.text     "content_html", limit: 65535
    t.boolean  "draft",        limit: 1,     default: false
    t.integer  "user_id",      limit: 4
    t.string   "slug",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name",                      limit: 80
    t.text     "summary",                   limit: 65535
    t.text     "description",               limit: 65535
    t.integer  "user_id",                   limit: 4
    t.integer  "target_amount_cents",       limit: 4,     default: 0,     null: false
    t.string   "target_amount_currency",    limit: 255,   default: "EUR", null: false
    t.integer  "collected_amount_cents",    limit: 4,     default: 0,     null: false
    t.string   "collected_amount_currency", limit: 255,   default: "EUR", null: false
    t.boolean  "draft",                     limit: 1,     default: false, null: false
    t.boolean  "disabled",                  limit: 1,     default: false, null: false
    t.boolean  "editor_pick",               limit: 1,     default: false, null: false
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.string   "image_file_name",           limit: 255
    t.string   "image_content_type",        limit: 255
    t.integer  "image_file_size",           limit: 4
    t.datetime "image_updated_at"
    t.integer  "category_id",               limit: 4
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "extended",                  limit: 4,     default: 0,     null: false
    t.datetime "old_end_date"
  end

  add_index "projects", ["category_id"], name: "index_projects_on_category_id", using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.boolean  "admin",                  limit: 1,   default: false, null: false
    t.boolean  "locked",                 limit: 1,   default: false, null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "projects", "categories"
  add_foreign_key "projects", "users"
end
