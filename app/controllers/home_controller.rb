class HomeController < ApplicationController
  # GET /appointments or /appointments.json
  def index
<<<<<<< Updated upstream
    if current_user
      if current_user.user?
        # if user is sign in but not yet completed profile
        if Patient.where(user_id: current_user.id).empty?
          session[:logon_name] = "User"
        else
        # if user is sign in and have completed profile
        patient_record = Patient.where(user_id: current_user.id).first
        @patient_id = patient_record.patient_id
        patient_name = patient_record.fname + " " + patient_record.lname
        @appointment = Appointment.where(patient_id: @patient_id).first
        session[:logon_name] = patient_name
        end
      elsif current_user.hospitaladmin?
        # logon user is hospital admin
        session[:logon_name] = "hospitaladmin"
        admin_details = Administrator.where(user_id: current_user.id).first
        clinic_from = Clinic.where(hospital_id: admin_details.hospital_id).pluck(:clinic_id).to_a
        @appointments = Appointment.includes(:doctor).includes(:clinic).where(clinic_id: clinic_from).all
        @patients = Patient.all
      else
        # logon user is admin
        session[:logon_name] = "superadmin"
        @appointments = Appointment.includes(:doctor).includes(:clinic).all
        @patients = Patient.all
      end
        @clinics = Clinic.joins(:hospital)
        @doctors = Doctor.joins(:clinic)
    end
=======
    #@appointments = Appointment.all
    @appointments = Appointment.includes(:doctor).includes(:clinic).all
    @clinics = Clinic.joins(:hospital)
    @doctors = Doctor.joins(:clinic)
>>>>>>> Stashed changes
  end
end
