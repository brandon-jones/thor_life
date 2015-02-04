class ForumsController < ApplicationController
  before_action :set_forum, only: [:show, :edit, :update, :destroy]

  # GET /forums
  # GET /forums.json
  def index
    @forums = Forum.groupped(params["id"])
    @this_forum = nil
    @topics = []
    @new_forum = Forum.new
    @parent_forum = nil
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
    @forums = Forum.groupped(params["id"])
    @this_forum = Forum.find params["id"]
    @new_forum = Forum.new
    @topics = @this_forum.topics
    my_breadcrumbs(@this_forum)
    @parent_forum = @this_forum.parent
  end

  # GET /forums/new
  def new
    @parent_forum = Forum.find_by_id(params["id"])
    @forum = Forum.new
  end

  # GET /forums/1/edit
  def edit
  end

  # POST /forums
  # POST /forums.json
  def create
    @forum = Forum.new(forum_params)

    respond_to do |format|
      if @forum.save
        format.html { redirect_to @forum, notice: 'Forum was successfully created.' }
        format.json { render :show, status: :created, location: @forum }
      else
        format.html { render :new }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /forums/1
  # PATCH/PUT /forums/1.json
  def update
    respond_to do |format|
      if @forum.update(forum_params)
        format.html { redirect_to @forum, notice: 'Forum was successfully updated.' }
        format.json { render :show, status: :ok, location: @forum }
      else
        format.html { render :edit }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
    @forum.destroy
    respond_to do |format|
      format.html { redirect_to forums_url, notice: 'Forum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forum
      @forum = Forum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def forum_params
      params.require(:forum).permit(:parent_id, :order, :created_by, :title, :deleted_by, :grouping_id, :locked, :admins_only, :main_feed, :deleted, :last_updated)
    end
end
