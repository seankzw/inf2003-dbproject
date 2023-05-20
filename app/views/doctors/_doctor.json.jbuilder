json.extract! doctor, :id, :clinic_id, :name, :contact, :email, :role, :created_at, :updated_at
json.url doctor_url(doctor, format: :json)
