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

ActiveRecord::Schema.define(version: 2022_04_28_065703) do

  create_table "settle_up_expenses", force: :cascade do |t|
    t.decimal "amount"
    t.string "who_paid_name"
    t.string "to_whom_name"
    t.integer "who_paid_id", null: false
    t.integer "to_whom_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["to_whom_id"], name: "index_settle_up_expenses_on_to_whom_id"
    t.index ["who_paid_id"], name: "index_settle_up_expenses_on_who_paid_id"
  end

  create_table "user_expenses", force: :cascade do |t|
    t.string "description"
    t.decimal "amount"
    t.integer "who_paid_user_id", null: false
    t.string "status"
    t.decimal "owes_you_amount"
    t.integer "who_to_pay_user_id", null: false
    t.integer "name_of_user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name_of_user_id"], name: "index_user_expenses_on_name_of_user_id"
    t.index ["who_paid_user_id"], name: "index_user_expenses_on_who_paid_user_id"
    t.index ["who_to_pay_user_id"], name: "index_user_expenses_on_who_to_pay_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "mobile_number"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "settle_up_expenses", "users", column: "to_whom_id"
  add_foreign_key "settle_up_expenses", "users", column: "who_paid_id"
  add_foreign_key "user_expenses", "users", column: "who_paid_user_id"
  add_foreign_key "user_expenses", "users", column: "who_to_pay_user_id"
end
