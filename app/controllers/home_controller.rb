class HomeController < ApplicationController
  def index
    if current_user
      if current_user.user?
        patient_record = Patient.where(user_id: current_user.id).first
        @patient_id = patient_record.patient_id
        @patient_name = patient_record.fname + " " + patient_record.lname
      end
    end
  end
end
