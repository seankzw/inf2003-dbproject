class PatientsController < ApplicationController
  before_action :set_patient, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :check_permission, only: %i[update index]

  require 'json'
  require 'securerandom'


  def check_permission
    if current_user.user? && !session.has_key?("patient_id")
      redirect_to new_patient_path
    end
  end

  # GET /patients or /patients.json
  def index
    @patients = Patient.all
  end

  # GET /patients/1 or /patients/1.json
  def show
    @patients = Patient.where(user_id: current_user.id)
    @medicines = Medicine.all
  end

  # GET /patients/new
  def new
    @patient = Patient.new
  end

  # GET /patients/1/edit
  def edit

  end

  # Add new med log for patient POST /patient/:id/medlog
  def addMedLog
    patient = Patient.find(params[:id])
    medLog = patient.med_log
    medicine = Medicine.find(params["medId"])

    ## Add new medlog
    if(medLog == nil)
      patient.med_log = JSON.generate(
        SecureRandom.uuid => {
          "med_name": medicine.name,
          "instruction": medicine.instruction,
          "dosage": medicine.dosage,
          "date_created": DateTime.now
        }
      )

    else
        medLog = JSON.parse(patient.med_log)

        print medLog
        medLog[SecureRandom.uuid] = {
            "med_name": medicine.name,
            "instruction": medicine.instruction,
            "dosage": medicine.dosage,
            "date_created": DateTime.now
          }

        patient.med_log = JSON.generate(medLog)
    end

    patient.save
  end

    # View patient med log
    def viewMedLog
      # Find the patient with the given ID
      @patient = Patient.find(params[:id])
  
      # Fetch the medical logs associated with the patient
      medlog_data = Medlog.where(patient_id: params[:id])
  
      # Initialize an empty array to store the medical logs
      @medlogs = []
  
      # Iterate through the medlog_data and populate the @medlogs array
      medlog_data.each do |medlog_entry|
        medlog_hash = {
          med_name: medlog_entry.med_name,
          instruction: medlog_entry.instruction,
          dosage: medlog_entry.dosage,
          date_created: medlog_entry.date_created.strftime('%d%m%y')
        }
        @medlogs << medlog_hash
    end
  # POST /patients or /patients.json
  def create
    @patient = Patient.new(patient_params)
    @patient.user_id = current_user.id
    current_year = Time.new.year
    dob_year = @patient.dob.year
    @patient.age = current_year - dob_year

    respond_to do |format|
      if @patient.save
        if current_user.user?
          session[:patient_id] = @patient.patient_id
          session[:logon_name] = @patient.fname + " " + @patient.lname
          notice = Hash['msg' => 'Profile created !', 'type' => 'success']
        else
          notice = Hash['msg' => 'Patient added !', 'type' => 'success']
        end
        flash[:notice] = notice
        format.html { redirect_to patient_url(@patient)}
        format.json { render :show, status: :created, location: @patient }
      else
        if current_user.user?
          notice = Hash['msg' => 'Profile creation failed!', 'type' => 'danger']
        else
          notice = Hash['msg' => 'Patient add failed!', 'type' => 'danger']
        end
        flash[:notice] = notice
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1 or /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        session[:logon_name] = @patient.fname + " " + @patient.lname
        if current_user.user?
          notice = Hash['msg' => 'Profile updated !', 'type' => 'success']
        else
          notice = Hash['msg' => 'Patient updated !', 'type' => 'success']
        end
        flash[:notice] = notice
        format.html { redirect_to patient_url(@patient) }
        format.json { render :show, status: :ok, location: @patient }
      else
        if current_user.user?
          notice = Hash['msg' => 'Profile update failed!', 'type' => 'danger']
        else
          notice = Hash['msg' => 'Patient update failed!', 'type' => 'danger']
        end
        notice = Hash['msg' => 'Patient update failed!', 'type' => 'danger']
        flash[:notice] = notice
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patients/1 or /patients/1.json
  def destroy
    @patient.destroy

    respond_to do |format|
      notice = Hash['msg' => 'Patient deleted !', 'type' => 'success']
      flash[:notice] = notice
      format.html { redirect_to patients_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def patient_params
      params.require(:patient).permit(:nric, :fname, :lname, :phone, :dob, :gender, :race, :vac_status, :drug_allergy, :med_log)
    end
end
