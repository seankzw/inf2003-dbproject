class AdministratorsController < ApplicationController
  before_action :set_administrator, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :check_permission

  def check_permission
    unless current_user.superadmin?
      redirect_to "/"
    end
  end

  # GET /administrators or /administrators.json
  def index
    @administrators = Administrator.includes(:hospital).includes(:user).all
  end

  # GET /administrators/1 or /administrators/1.json
  def show
  end

  # GET /administrators/new
  def new
    @administrator = Administrator.new
    @users = User.all
    @hospitals = Hospital.all
  end

  # GET /administrators/1/edit
  def edit
    @users = User.all
    @hospitals = Hospital.all
  end

  # POST /administrators or /administrators.json
  def create
    @administrator = Administrator.new(administrator_params)

    respond_to do |format|
      if @administrator.save
        format.html { redirect_to administrator_url(@administrator), notice: "Administrator was successfully created." }
        format.json { render :show, status: :created, location: @administrator }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /administrators/1 or /administrators/1.json
  def update
    respond_to do |format|
      if @administrator.update(administrator_params)
        format.html { redirect_to administrator_url(@administrator), notice: "Administrator was successfully updated." }
        format.json { render :show, status: :ok, location: @administrator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @administrator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrators/1 or /administrators/1.json
  def destroy
    @administrator.destroy

    respond_to do |format|
      format.html { redirect_to administrators_url, notice: "Administrator was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_administrator
      @administrator = Administrator.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def administrator_params
      params.require(:administrator).permit(:user_id, :hospital_id)
    end
end
