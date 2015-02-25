class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :new_password]
  before_action :authenticated_king, only: :destroy
  before_action :authenticated_super_admin, except: [:destroy, :show, :edit, :new_password, :create, :update, :new]
  # before_action :authorize_admin, only: [:index]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @forum_dropdown = Forum.all.pluck(:title, :id) || []
  end

  def new_password

  end

  def promote

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    # if params["commit"] == 'Crop'
    #   if @user.update(user_params)
    #     # @user.reprocess_avatar
    #     # @user.destroy_original
    #   end
    #   redirect_to user_path(@user.id) and return
    # end
    if params["user"]["current_password"]
      unless @user.authenticate(params["user"]["current_password"])
        redirect_to update_password_user_path(@user), :flash => { :error => "Current password is incorrect!" }
        return
      end
      notice = "Password was updated successfully"
    else
      notice = 'User was successfully updated.'
    end
    if @user.update(user_params)
      ar = {}
      ar["user_id"] = @user.id
      ar["admin_type"] = params["user"]["admin_level"] if params["user"]["admin_level"].present?
      ar["admin_id"] = params["user"]["admin_obj_id"] if params["user"]["admin_obj_id"].present?

      AdminRole.create(ar) if ar.keys.count > 1
      session[:user_id] = @user.id if current_user == @user
      
      # render 'cropper' and return 
      redirect_to user_path(@user.id) and return

      # format.html { redirect_to @user, notice: notice }
      # format.json { render :show, status: :ok, location: @user }
    else
      @forum_dropdown = Forum.all.pluck(:title, :id) || []
      render :edit
      # format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :password, :password_confirmation,:email, :email_verified, :phone_number, :phone_provider, :about_me, :banned, :permma_banned, :banned_by, :customer_id, :image, :crop_x, :crop_y, :crop_w, :crop_h, :admin_level, :admin_obj_id)
    end
end
