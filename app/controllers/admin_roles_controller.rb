class AdminRolesController < ApplicationController
  before_action :set_admin_role, only: [:show, :edit, :update, :destroy]
  before_action :authenticated_king, only: :destroy
  before_action :authenticated_super_admin, except: [:destroy, :index]
  # GET /admin_roles
  # GET /admin_roles.json
  def index
    @admin_roles = AdminRole.all
  end

  # GET /admin_roles/1
  # GET /admin_roles/1.json
  def show
  end

  # GET /admin_roles/new
  def new
    @admin_role = AdminRole.new
  end

  # GET /admin_roles/1/edit
  def edit
  end

  # POST /admin_roles
  # POST /admin_roles.json
  def create
    @admin_role = AdminRole.new(admin_role_params)

    respond_to do |format|
      if @admin_role.save
        format.html { redirect_to @admin_role, notice: 'Admin role was successfully created.' }
        format.json { render :show, status: :created, location: @admin_role }
      else
        format.html { render :new }
        format.json { render json: @admin_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_roles/1
  # PATCH/PUT /admin_roles/1.json
  def update
    respond_to do |format|
      if @admin_role.update(admin_role_params)
        format.html { redirect_to @admin_role, notice: 'Admin role was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_role }
      else
        format.html { render :edit }
        format.json { render json: @admin_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_roles/1
  # DELETE /admin_roles/1.json
  def destroy
    @admin_role.destroy
    respond_to do |format|
      format.html { redirect_to admin_roles_url, notice: 'Admin role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_role
      @admin_role = AdminRole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_role_params
      params.require(:admin_role).permit(:user_id, :admin_type, :admin_id)
    end
end
