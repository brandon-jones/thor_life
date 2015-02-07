class UserGameIdsController < ApplicationController
  before_action :set_user_game_id, only: [:show, :edit, :update, :destroy]

  # GET /user_game_ids
  # GET /user_game_ids.json
  def index
    @user_game_ids = UserGameId.all
  end

  # GET /user_game_ids/1
  # GET /user_game_ids/1.json
  def show
  end

  # GET /user_game_ids/new
  def new
    @user_game_id = UserGameId.new
  end

  # GET /user_game_ids/1/edit
  def edit
  end

  # POST /user_game_ids
  # POST /user_game_ids.json
  def create
    @user_game_id = UserGameId.new(user_game_id_params)

    respond_to do |format|
      if @user_game_id.save
        format.html { redirect_to @user_game_id, notice: 'User game was successfully created.' }
        format.json { render :show, status: :created, location: @user_game_id }
      else
        format.html { render :new }
        format.json { render json: @user_game_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_game_ids/1
  # PATCH/PUT /user_game_ids/1.json
  def update
    respond_to do |format|
      if @user_game_id.update(user_game_id_params)
        format.html { redirect_to @user_game_id, notice: 'User game was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_game_id }
      else
        format.html { render :edit }
        format.json { render json: @user_game_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_game_ids/1
  # DELETE /user_game_ids/1.json
  def destroy
    @user_game_id.destroy
    respond_to do |format|
      format.html { redirect_to user_game_ids_url, notice: 'User game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_game_id
      @user_game_id = UserGameId.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_game_id_params
      params.require(:user_game_id).permit(:game_id, :in_game_name, :user_id, :banned, :permma_banned, :user_verified, :verified_by)
    end
end
