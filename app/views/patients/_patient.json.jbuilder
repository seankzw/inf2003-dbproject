json.extract! patient, :id, :nric, :fname, :lname, :phone, :dob, :gender, :vac_status, :drug_allergy,  :user_id, :med_log, :created_at, :updated_at
json.url patient_url(patient, format: :json)
