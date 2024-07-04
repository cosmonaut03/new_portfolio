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

ActiveRecord::Schema[7.1].define(version: 2024_07_04_022128) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "group_id"
    t.string "name", null: false
    t.text "description"
    t.integer "position", null: false
    t.boolean "is_uncategorized", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id", "is_uncategorized"], name: "index_categories_on_group_id_and_is_uncategorized", unique: true, where: "(is_uncategorized = true)"
    t.index ["group_id"], name: "index_categories_on_group_id"
    t.index ["user_id", "is_uncategorized"], name: "index_categories_on_user_id_and_is_uncategorized", unique: true, where: "(is_uncategorized = true)"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "home_layouts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id"
    t.boolean "is_visible", default: true
    t.integer "position"
    t.boolean "is_personal", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_home_layouts_on_group_id"
    t.index ["user_id"], name: "index_home_layouts_on_user_id"
  end

  create_table "user_groups", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "group_id", null: false
    t.integer "role", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_user_groups_on_group_id"
    t.index ["user_id", "group_id"], name: "index_user_groups_on_user_id_and_group_id", unique: true
    t.index ["user_id"], name: "index_user_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name"
    t.string "user_name", null: false
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "categories", "groups"
  add_foreign_key "categories", "users"
  add_foreign_key "home_layouts", "groups"
  add_foreign_key "home_layouts", "users"
  add_foreign_key "user_groups", "groups"
  add_foreign_key "user_groups", "users"
end
