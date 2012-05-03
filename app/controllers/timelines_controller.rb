class TimelinesController < ApplicationController
  # GET /timelines
  # GET /timelines.json
  
  # invoke protection methods before actions
  # note that our correct_user method defines @topic for EDIT and UPDATE
  before_filter :logged_in_user, only: [:new, :create, :show, :index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :block,          only: :destroy


  def index
    @timelines = Timeline.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @timelines }
    end
  end

  # GET /timelines/1
  # GET /timelines/1.json
  def show
    @timeline = Timeline.find(params[:id])

    # authenticate user for editing capabilities
    if signed_in?
      @auth = (@timeline.user_id == current_user.id)
    else
      @auth = false
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @timeline }
    end
  end

  # GET /timelines/new
  # GET /timelines/new.json
  def new
    @timeline = Timeline.new
    @timeline.categories.build
    @timeline.categories << Category.new
    @timeline.categories << Category.new
    @timeline.categories << Category.new
    @timeline.categories << Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @timeline }
    end
  end

  # GET /timelines/1/edit
  def edit
    @timeline = Timeline.find(params[:id])
  end

  # POST /timelines
  # POST /timelines.json
  def create
    @timeline = Timeline.new(params[:timeline])
    
    @timeline.user_id = current_user.id

    respond_to do |format|
      if @timeline.save
        format.html { redirect_to @timeline, notice: 'Timeline was successfully created.' }
        format.json { render json: @timeline, status: :created, location: @timeline }
      else
        format.html { render action: "new" }
        format.json { render json: @timeline.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /timelines/1
  # PUT /timelines/1.json
  def update
    @timeline = Timeline.find(params[:id])

    respond_to do |format|
      if @timeline.update_attributes(params[:timeline])
        format.html { redirect_to @timeline, notice: 'Timeline was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @timeline.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timelines/1
  # DELETE /timelines/1.json
  def destroy
    @timeline = Timeline.find(params[:id])
    @timeline.destroy

    respond_to do |format|
      format.html { redirect_to timelines_url }
      format.json { head :no_content }
    end
  end

  private
    # check that user is logged_in
    def logged_in_user
      unless signed_in?
        redirect_to signin_path, notice: "Please sign in."
      end
    end

    # check that the user is correct
    def correct_user
      @timeline = Timeline.find(params[:id])
      @user = User.find(@timeline.user_id)
      redirect_to root_path unless current_user?(@user)
    end

    # block access
    def block
      redirect_to root_path
    end

end
