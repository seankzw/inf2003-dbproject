class ClinicsController < ApplicationController
  before_action :set_clinic, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /clinics or /clinics.json
  def index
    @clinics = Clinic.joins(:hospital) #default
    @clinic_hospital = Hash[]

    for eachClinic in @clinics do
      if @clinic_hospital.key?(eachClinic.hospital.name)
        @clinic_hospital[eachClinic.hospital.name].append(eachClinic)
      else
        @clinic_hospital[eachClinic.hospital.name] = []
        @clinic_hospital[eachClinic.hospital.name].append(eachClinic)
      end
    end
  end

  # GET /clinics/1 or /clinics/1.json
  def show
  end

  # GET /clinics/new
  def new
    @hospitals = Hospital.all
    @clinic = Clinic.new
    @hospitals = Hospital.all
  end

  # GET /clinics/1/edit
  def edit
    @hospitals = Hospital.all
  end

  # POST /clinics or /clinics.json
  def create
    @clinic = Clinic.new(clinic_params)

    respond_to do |format|
      if @clinic.save
        notice = Hash['msg' => 'Clinic added !', 'type' => 'success']
        flash[:notice] = notice
        format.html { redirect_to clinic_url(@clinic)}
        format.json { render :show, status: :created, location: @clinic }
      else
        notice = Hash['msg' => 'Clinic add failed !', 'type' => 'danger']
        flash[:notice] = notice
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinics/1 or /clinics/1.json
  def update

    respond_to do |format|
      if @clinic.update(clinic_params)
        notice = Hash['msg' => 'Clinic updated !', 'type' => 'success']
        flash[:notice] = notice
        format.html { redirect_to clinic_url(@clinic)}
        format.json { render :show, status: :ok, location: @clinic }
      else
        notice = Hash['msg' => 'Clinic update failed !', 'type' => 'danger']
        flash[:notice] = notice
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinics/1 or /clinics/1.json
  def destroy
    @clinic.destroy
    respond_to do |format|
      notice = Hash['msg' => 'Clinic deleted !', 'type' => 'success']
      flash[:notice] = notice
      format.html { redirect_to clinics_url}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clinic
      @clinic = Clinic.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def clinic_params
      params.require(:clinic).permit(:hospital_id, :name, :location)
    end
end
