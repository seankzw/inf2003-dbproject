class HospitalsController < ApplicationController
  before_action :set_hospital, only: %i[ show edit update destroy ]

  # GET /hospitals or /hospitals.json
  def index
    @hospitals = Hospital.all
  end

  # GET /hospitals/1 or /hospitals/1.json
  def show
  end

  # GET /hospitals/new
  def new
    if current_user.superadmin?
      @hospital = Hospital.new
    else
      redirect_to "/"
    end
  end

  # GET /hospitals/1/edit
  def edit
  end

  # POST /hospitals or /hospitals.json
  def create
    @hospital = Hospital.new(hospital_params)

    respond_to do |format|
      if @hospital.save
        notice = Hash['msg' => 'Hospital added !', 'type' => 'success']
        flash[:notice] = notice
        # format.html { redirect_to hospital_url(@hospital), notice: "Hospital was successfully created." }
        format.html { redirect_to hospital_url(@hospital)}
        format.json { render :show, status: :created, location: @hospital }
      else
        notice = Hash['msg' => 'Hospital add failed!', 'type' => 'danger']
        flash[:notice] = notice
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hospitals/1 or /hospitals/1.json
  def update
    notice = Hash['msg' => 'Hospital updated !', 'type' => 'success']
    flash[:notice] = notice

    respond_to do |format|
      if @hospital.update(hospital_params)
        format.html { redirect_to hospital_url(@hospital)}
        format.json { render :show, status: :ok, location: @hospital }
      else
        notice = Hash['msg' => 'Hospital update failed!', 'type' => 'danger']
        flash[:notice] = notice
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hospitals/1 or /hospitals/1.json
  def destroy
    @hospital.destroy
    notice = Hash['msg' => 'Hospital deleted !', 'type' => 'success']
    flash[:notice] = notice

    respond_to do |format|
      format.html { redirect_to hospitals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hospital
      @hospital = Hospital.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hospital_params
      params.require(:hospital).permit(:name, :location)
    end
end
