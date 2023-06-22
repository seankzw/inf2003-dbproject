class ClinicsController < ApplicationController
  before_action :set_clinic, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /clinics or /clinics.json
  def index
    @clinics = Clinic.joins(:hospital)
  end

  # GET /clinics/1 or /clinics/1.json
  def show
  end

  # GET /clinics/new
  def new
    @clinic = Clinic.new
    @hospitals = Hospital.all
  end

  # GET /clinics/1/edit
  def edit
    @hospitals = Hospital.all
  end

  # POST /clinics or /clinics.json
  def create
    notice = Hash['msg' => 'Clinic created !', 'type' => 'success']
    @clinic = Clinic.new(clinic_params)

    respond_to do |format|
      if @clinic.save
      flash[:notice] = notice
        format.html { redirect_to clinic_url(@clinic)}
        format.json { render :show, status: :created, location: @clinic }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clinics/1 or /clinics/1.json
  def update
    notice = Hash['msg' => 'Clinic updated !', 'type' => 'success']
    
    respond_to do |format|
      if @clinic.update(clinic_params)
        flash[:notice] = notice
        format.html { redirect_to clinic_url(@clinic)}
        format.json { render :show, status: :ok, location: @clinic }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @clinic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clinics/1 or /clinics/1.json
  def destroy
    notice = Hash['msg' => 'Clinic deleted !', 'type' => 'success']
    @clinic.destroy
    respond_to do |format|
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
