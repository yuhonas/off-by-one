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

ActiveRecord::Schema[7.1].define(version: 2024_06_18_231353) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "student_test_result_sets", force: :cascade do |t|
    t.string "request_id", null: false
    t.text "xml_data", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "student_test_results", force: :cascade do |t|
    t.string "student_number"
    t.string "test_id"
    t.integer "marks_available"
    t.integer "marks_obtained"
    t.datetime "scanned_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "student_test_result_set_id"
    t.index ["student_number"], name: "index_student_test_results_on_student_number"
    t.index ["student_test_result_set_id"], name: "index_student_test_results_on_student_test_result_set_id"
    t.index ["test_id"], name: "index_student_test_results_on_test_id"
  end

  add_foreign_key "student_test_results", "student_test_result_sets"
end
