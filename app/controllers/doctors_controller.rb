class DoctorsController < ApplicationController
  before_action :set_doctor, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :check_permission

  def check_permission
    if current_user.user?
      redirect_to "/"
    end
  end

  # GET /doctors or /doctors.json
  def index
    @doctors = Doctor.joins(:clinic)
  end

  # GET /doctors/1 or /doctors/1.json
  def show
  end

  # GET /doctors/new
  def new
    @doctor = Doctor.new
  end

  # GET /doctors/1/edit
  def edit
  end

  # POST /doctors or /doctors.json
  def create
    @doctor = Doctor.new(doctor_params)

    respond_to do |format|
      if @doctor.save
        notice = Hash['msg' => 'Doctor added !', 'type' => 'success']
        flash[:notice] = notice
        format.html { redirect_to doctor_url(@doctor) }
        format.json { render :show, status: :created, location: @doctor }
      else
        notice = Hash['msg' => 'Doctor add failed !', 'type' => 'danger']
        flash[:notice] = notice
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /doctors/1 or /doctors/1.json
  def update
    respond_to do |format|
      if @doctor.update(doctor_params)
        notice = Hash['msg' => 'Doctor updated !', 'type' => 'success']
        flash[:notice] = notice
        format.html { redirect_to doctor_url(@doctor) }
        format.json { render :show, status: :ok, location: @doctor }
      else
        notice = Hash['msg' => 'Doctor update failed !', 'type' => 'danger']
        flash[:notice] = notice
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /doctors/1 or /doctors/1.json
  def destroy
    @doctor.destroy

    respond_to do |format|
      notice = Hash['msg' => 'Doctor removed !', 'type' => 'success']
      flash[:notice] = notice
      format.html { redirect_to doctors_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_doctor
      @doctor = Doctor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def doctor_params
      params.require(:doctor).permit(:clinic_id, :name, :contact, :email, :role)
    end
end
