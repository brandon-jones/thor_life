class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    my_breadcrumbs(@topic)
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/1
  # PATCH/PUT /topics/1.json
  def update
    if params["what"]
      topic = Topic.find_by_id(params["id"])
      case params["what"]
        when 'lock'
          topic.update_attribute(:locked, true)
        when 'un_lock'
          topic.update_attribute(:locked, false)
        when 'delete'
          topic.update_attributes(:deleted => true, :deleted_by => current_user.id)
        when 'un_delete'
          topic.update_attributes(:deleted => false)
        when 'destroy'
          topic.destroy
          topic = nil
        end
      render partial: 'layouts/tf_row', locals: { obj: topic, admin: true } and return
    else
      respond_to do |format|
        if @topic.update(topic_params)
          format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
          format.json { render :show, status: :ok, location: @topic }
        else
          format.html { render :edit }
          format.json { render json: @topic.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def topic_params
      params.require(:topic).permit(:grouping_id, :title, :created_by, :sticky, :order, :body, :locked, :deleted, :deleted_by, :last_updated, :forum_id)
    end
end
