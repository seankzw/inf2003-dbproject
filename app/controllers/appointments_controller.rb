class AppointmentsController < ApplicationController
  before_action :set_appointment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /appointments or /appointments.json
  def index
    #@appointments = Appointment.all
    if current_user.hospitaladmin? || current_user.superadmin?
      @appointments = Appointment.includes(:doctor).includes(:clinic).all
      p @appointments
    else
      if !Patient.where(user_id: current_user.id).empty?
        patient_id = Patient.where(user_id: current_user.id).first
        @appointments = Appointment.includes(:doctor).includes(:clinic).where(patient_id: patient_id.patient_id)
      end
    end
  end

  # GET /appointments/1 or /appointments/1.json
  def show
    @clinics = Clinic.all
    @doctors = Doctor.all
    @patients = Patient.all

    @clinic = Clinic.where(clinic_id: @appointment.clinic_id).first
    @doctor = Doctor.where(doctor_id: @appointment.doctor_id).first
    @patient = Patient.where(patient_id: @appointment.patient_id).first

  end

  # GET /appointments/new
  def new
      if current_user.user?
          if Patient.where(user_id: current_user.id).empty?
            notice = Hash['msg' => 'Please complete your user profile !', 'type' => 'danger']
            flash[:notice] = notice
            puts "User hasn't completed profile -- Redirecting to new_patient_path"
            redirect_to new_patient_path
          end

          #user = Patient.where(user_id: current_user.id).first
          #@user_name = user.fname + " "+ user.lname
        end
        p "User completed profile -- Proceeding to appointment page"
        @appointment = Appointment.new
        @user_name = current_user.id
        @hospitals = Hospital.all
        @clinics = Clinic.all
        @doctors = Doctor.all
  end

  # GET /appointments/1/edit
  def edit
    @appointment.doctor_id = params[:doctor_id]
    @clinics = Clinic.all
    @doctors = Doctor.all
  end

  # POST /appointments or /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.clinic_id = params[:clinic_id]
    @appointment.doctor_id = params[:doctor_id]
    patient_record = Patient.where(user_id: current_user.id).first
    @appointment.patient_id = patient_record.patient_id

    respond_to do |format|
      if @appointment.save
        notice = Hash['msg' => 'Appointment added !', 'type' => 'success']
        flash[:notice] = notice
        format.html { redirect_to appointment_url(@appointment)}
        format.json { render :show, status: :created, location: @appointment }
      else
        notice = Hash['msg' => 'Appointment adding failed!', 'type' => 'danger']
        flash[:notice] = notice
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1 or /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        notice = Hash['msg' => 'Appointment updated !', 'type' => 'success']
        flash[:notice] = notice
        format.html { redirect_to appointment_url(@appointment)}
        format.json { render :show, status: :ok, location: @appointment }
      else
        notice = Hash['msg' => 'Patient update failed!', 'type' => 'danger']
        flash[:notice] = notice
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1 or /appointments/1.json
  def destroy
    @appointment.destroy

    respond_to do |format|
      notice = Hash['msg' => 'Appointment deleted !', 'type' => 'success']
      flash[:notice] = notice
      format.html { redirect_to appointments_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_appointment
      @appointment = Appointment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def appointment_params
      params.require(:appointment).permit(:patient_id, :doctor_id, :clinic_id, :description, :date)
    end
end
