# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_15_162543) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "platforms", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_platforms_on_organization_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_products_on_organization_id"
  end

  create_table "test_cases", force: :cascade do |t|
    t.bigint "test_suite_id", null: false
    t.string "name"
    t.integer "mets_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "test_steps_count", default: 0
    t.index ["test_suite_id"], name: "index_test_cases_on_test_suite_id"
  end

  create_table "test_plans", force: :cascade do |t|
    t.bigint "platform_id", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "organization_id"
    t.index ["platform_id"], name: "index_test_plans_on_platform_id"
    t.index ["product_id"], name: "index_test_plans_on_product_id"
  end

  create_table "test_steps", force: :cascade do |t|
    t.bigint "test_case_id", null: false
    t.integer "workflow_id"
    t.string "action"
    t.integer "order"
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["test_case_id"], name: "index_test_steps_on_test_case_id"
  end

  create_table "test_suites", force: :cascade do |t|
    t.integer "test_plan_id"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "test_cases_count", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organization_id"], name: "index_users_on_organization_id"
  end

  create_table "workflow_steps", force: :cascade do |t|
    t.bigint "workflow_id", null: false
    t.string "action"
    t.integer "order"
    t.string "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["workflow_id"], name: "index_workflow_steps_on_workflow_id"
  end

  create_table "workflows", force: :cascade do |t|
    t.bigint "test_plan_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "workflow_steps_count", default: 0
    t.index ["test_plan_id"], name: "index_workflows_on_test_plan_id"
  end

  add_foreign_key "platforms", "organizations"
  add_foreign_key "products", "organizations"
  add_foreign_key "test_cases", "test_suites"
  add_foreign_key "test_plans", "organizations"
  add_foreign_key "test_plans", "platforms"
  add_foreign_key "test_plans", "products"
  add_foreign_key "test_steps", "test_cases"
  add_foreign_key "test_suites", "test_plans"
  add_foreign_key "users", "organizations"
  add_foreign_key "workflow_steps", "workflows"
  add_foreign_key "workflows", "test_plans"
end
