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

ActiveRecord::Schema[7.0].define(version: 2023_06_16_142638) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "user_role", ["superadmin", "hospitaladmin", "user"]

  create_table "appointments", force: :cascade do |t|
    t.integer "patient_id"
    t.integer "doctor_id"
    t.integer "clinic_id"
    t.string "name"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clinics", primary_key: "clinic_id", id: :integer, default: -> { "nextval('clinic_clinic_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "hospital_id", null: false
    t.string "name", limit: 255, null: false
    t.string "location", limit: 255, null: false
  end

  create_table "doctors", primary_key: "doctor_id", id: :integer, default: -> { "nextval('doctor_doctor_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "clinic_id", null: false
    t.string "name", limit: 255, null: false
    t.integer "contact", null: false
    t.string "email", limit: 255, null: false
    t.string "role", limit: 255, null: false
  end

  create_table "hospitals", primary_key: "hospital_id", id: :integer, default: -> { "nextval('hospital_hospital_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "location", limit: 255, null: false
  end

  create_table "patients", primary_key: "patient_id", id: :integer, default: -> { "nextval('patient_patient_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "nric", limit: 256, null: false
    t.string "fname", limit: 256, null: false
    t.string "lname", limit: 256, null: false
    t.integer "phone", null: false
    t.date "dob", null: false
    t.string "gender", limit: 256, null: false
    t.string "race", limit: 256, null: false
    t.string "vac_status", limit: 256, null: false
    t.string "drug_allergy", limit: 256, null: false
    t.index ["nric"], name: "patient_nric_key", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "clinics", "hospitals", primary_key: "hospital_id", name: "hospital_id"
  add_foreign_key "doctors", "clinics", primary_key: "clinic_id", name: "clinic_id"
end
