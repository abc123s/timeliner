class CategoriesController < ApplicationController
  before_filter :logged_in_user, only: [:new, :create, :show, :index, :edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :block,          only: [:destroy, :index, :show]


  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
    @category.events.build
    @category.events.each do |event|
      if event.title == ""
        event.build_image
        event.build_location
        event.build_audio
        event.build_video
      end
    end
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category.timeline, notice: 'Event was successfully added.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
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
      @category = Category.find(params[:id])
      @user = @category.timeline.user
      redirect_to root_path unless current_user?(@user)
    end

    # block access
    def block
      redirect_to root_path
    end

end
