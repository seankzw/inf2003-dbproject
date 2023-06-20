class HomeController < ApplicationController
  # GET /appointments or /appointments.json
  def index
    if current_user
      if current_user.user?
        if Patient.where(user_id: current_user.id).empty?
          session[:logon_name] = "User"
        else
        patient_record = Patient.where(user_id: current_user.id).first
        @patient_id = patient_record.patient_id
        patient_name = patient_record.fname + " " + patient_record.lname
        @appointment = Appointment.where(patient_id: @patient_id).first
        session[:logon_name] = patient_name
        end
      elsif current_user.hospitaladmin?
        session[:logon_name] = "hospitaladmin"
        @appointments = Appointment.includes(:doctor).includes(:clinic).all
        @patients = Patient.all
      else
        session[:logon_name] = "superadmin"
        @appointments = Appointment.includes(:doctor).includes(:clinic).all
        @patients = Patient.all
      end
        @clinics = Clinic.joins(:hospital)
        @doctors = Doctor.joins(:clinic)
    end
  end
end
