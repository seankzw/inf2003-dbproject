json.extract! appointment, :id, :patient_id, :doctor_id, :clinic_id, :name, :date, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
