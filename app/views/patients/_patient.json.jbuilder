json.extract! patient, :id, :nric, :fname, :lname, :phone, :dob, :gender, :vac_status, :drug_allergy, :created_at, :updated_at
json.url patient_url(patient, format: :json)
