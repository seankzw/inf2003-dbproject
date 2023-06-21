# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create
     super do |resource|
        if current_user
          if current_user.user?
            # if user is sign in but not yet completed profile
            if Patient.where(user_id: current_user.id).empty?
              session[:logon_name] = "User"
            else
            # if user is sign in and have completed profile
            patient_record = Patient.where(user_id: current_user.id).first
            patient_name = patient_record.fname + " " + patient_record.lname
            session[:logon_name] = patient_name
            end
          elsif current_user.hospitaladmin?
            # logon user is hospital admin
            session[:logon_name] = "hospitaladmin"
          else
            # logon user is admin
            session[:logon_name] = "superadmin"
          end
        end
      end
   end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
