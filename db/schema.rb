# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_10_28_153051) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string "name"
    t.integer "shares_available"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "quantity"
    t.integer "price"
    t.integer "status", default: 0
    t.bigint "user_id"
    t.bigint "business_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_orders_on_business_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "resource", null: false
    t.jsonb "actions", default: {}, null: false
    t.string "accessor_type"
    t.bigint "accessor_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["accessor_type", "accessor_id"], name: "index_permissions_on_accessor"
    t.index ["actions"], name: "index_permissions_on_actions"
    t.index ["resource", "accessor_id", "accessor_type"], name: "index_permissions_on_resource_and_accessor_id_and_accessor_type", unique: true
  end

  create_table "purchases", force: :cascade do |t|
    t.integer "quantity"
    t.integer "price"
    t.bigint "user_id"
    t.bigint "business_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_purchases_on_business_id"
    t.index ["user_id"], name: "index_purchases_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.integer "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.bigint "role_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "jti"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "businesses", "users"
  add_foreign_key "orders", "businesses"
  add_foreign_key "orders", "users"
  add_foreign_key "purchases", "businesses"
  add_foreign_key "purchases", "users"
  add_foreign_key "users", "roles"
end
