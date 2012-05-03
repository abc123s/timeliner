class EventsController < ApplicationController
  before_filter :logged_in_user, only: [:new, :create, :show, :index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :block,          only: [:destroy, :index]
  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    @event.build_image
    @event.build_location
    @event.build_video
    @event.build_audio

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @event.build_image
    @event.build_location
    @event.build_video
    @event.build_audio
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
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
      @event = Event.find(params[:id])
      @user = @event.category.timeline.user
      redirect_to root_path unless current_user?(@user)
    end

    # block access
    def block
      redirect_to root_path
    end

end
