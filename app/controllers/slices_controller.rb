class SlicesController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

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
    end
  end

  # GET /slices/1/edit
  def edit
    @slice = Slice.find(params[:id])
  end

  # POST /slices
  # POST /slices.json
  def create
    @slice = Slice.new(params[:slice])

    respond_to do |format|
      if @slice.save
        flash[:notice] = 'Slice was successfully created.'
        format.html { redirect_to bill_url @slice.bill }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /slices/1
  # PUT /slices/1.json
  def update
    @slice = Slice.find(params[:id])

    respond_to do |format|
      if @slice.update_attributes(params[:slice])
        flash[:notice] = 'Slice was successfully updated.'
        format.html { redirect_to slice_path @slice.bill, @slice }
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
    bill = @slice.bill
    @slice.destroy

    redirect_to bill
  end
end
