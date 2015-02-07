class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :new_password]
  before_filter :authenticated_super_admin, only: [:index]
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
  end

  def new_password

  end

  # POST /users
  # POST /users.json
  def create
    binding.pry
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id if current_user == @user
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
    if params["commit"] == 'Crop'
      if @user.update(user_params)
        # @user.reprocess_avatar
        # @user.destroy_original
      end
      redirect_to user_path(@user.id) and return
    end
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
      session[:user_id] = @user.id if current_user == @user
      
      render 'cropper' and return 
      # format.html { redirect_to @user, notice: notice }
      # format.json { render :show, status: :ok, location: @user }
    else
      render :edit
      # format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end

  def image_upload
    binding.pry
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
      params.require(:user).permit(:username, :password, :password_confirmation,:email, :email_verified, :phone_number, :phone_provider, :about_me, :banned, :permma_banned, :banned_by, :customer_id, :image, :crop_x, :crop_y, :crop_w, :crop_h)
    end
end
