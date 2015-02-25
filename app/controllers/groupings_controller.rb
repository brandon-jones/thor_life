class GroupingsController < ApplicationController
  before_action :set_grouping, only: [:show, :edit, :update, :destroy]

  # GET /groupings
  # GET /groupings.json
  def index
    @groupings = Grouping.all
  end

  # GET /groupings/1
  # GET /groupings/1.json
  def show
  end

  # GET /groupings/new
  def new
    @grouping = Grouping.new
  end

  # GET /groupings/1/edit
  def edit
  end

  # POST /groupings
  # POST /groupings.json
  def create
    @grouping = Grouping.new(grouping_params)
    if @grouping.save
      if params["ajax"]
        @games = [[ '', -2 ]] + Game.all.pluck(:name, :id)
        @game_instances = []
        render partial: 'layouts/forums_grouping', locals: { forum_group_id: @grouping.id, forum_group: @grouping, this_forum: @grouping.forum, forums: @grouping.forum.get_groups_and_grouped_forums[1] } and return
      else
        redirect_to @grouping, notice: 'Grouping was successfully created.'
      end
    else
      if params["ajax"]
        render nothing: true;
      else
        render :new
      end
    end
  end

  # PATCH/PUT /groupings/1
  # PATCH/PUT /groupings/1.json
  def update
    respond_to do |format|
      if @grouping.update(grouping_params)
        format.html { redirect_to @grouping, notice: 'Grouping was successfully updated.' }
        format.json { render :show, status: :ok, location: @grouping }
      else
        format.html { render :edit }
        format.json { render json: @grouping.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groupings/1
  # DELETE /groupings/1.json
  def destroy
    count = @grouping.forum.children.where(grouping_id: nil).count
    @grouping.forums.each do |forum|
      forum.grouping_id = nil;
      forum.row_order_position = count
      forum.save
    end
    @grouping.destroy
    if params["ajax"]
      render nothing: true
    else
      redirect_to groupings_url, notice: 'Grouping was successfully destroyed.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_grouping
      @grouping = Grouping.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def grouping_params
      params.require(:grouping).permit(:title, :forum_id)
    end
end
