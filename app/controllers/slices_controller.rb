class SlicesController < ApplicationController

  before_filter :authenticate_user!

  # GET /slices
  # GET /slices.json
  def index
    @slices = Slice.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slices }
    end
  end

  # GET /slices/1
  # GET /slices/1.json
  def show
    @slice = Slice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @slice }
    end
  end

  # GET /slices/new
  # GET /slices/new.json
  def new
    @slice = Slice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slice }
    end
  end

  # GET /slices/1/edit
  def edit
    @slice = Slice.find(params[:id])
  end

  # POST /slices
  # POST /slices.json
  def create
    @slice = Slice.new(
      :amount => params[:amount]
    )
    @slice.bill_id = params[:bill]
    @slice.user_id = params[:user]

    respond_to do |format|
      if @slice.save
        format.html { redirect_to @slice, notice: 'Slice was successfully created.' }
        format.json { render json: @slice, status: :created, location: @slice }
      else
        format.html { render action: "new" }
        format.json { render json: @slice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /slices/1
  # PUT /slices/1.json
  def update
    @slice = Slice.find(params[:id])

    respond_to do |format|
      if @slice.update_attributes(params[:slice])
        format.html { redirect_to @slice, notice: 'Slice was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @slice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slices/1
  # DELETE /slices/1.json
  def destroy
    @slice = Slice.find(params[:id])
    @slice.destroy

    respond_to do |format|
      format.html { redirect_to slices_url }
      format.json { head :ok }
    end
  end
end
