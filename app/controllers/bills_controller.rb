class BillsController < ApplicationController

  before_filter :authenticate_user!

  # GET /bills
  def index
    @bills = Bill.all

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /bills/1
  def show
    @bill = Bill.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit
    @bill = Bill.find(params[:id])
  end

  # POST /bills
  def create
    @bill = Bill.new(params[:bill])

    respond_to do |format|
      if @bill.save
        flash[:notice] = 'Bill was successfully created.'
        format.html { redirect_to @bill }
      else
        flash[:warning] = "There was a problem creating the Bill. Please try again."
        format.html { render action: "new" }
        format.json { render json: {"status" => "failure", "message" => "There was a problem creating the Bill. Please try again."} }
      end
    end
  end

  # PUT /bills/1
  def update
    @bill = Bill.find(params[:id])

    respond_to do |format|
      if @bill.update_attributes!(params[:bill])
        flash[:notice] = 'Bill was successfully updated.'
        format.html { redirect_to @bill }
      else
        flash[:warning] = "There was an error"
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /bills/1
  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy
    redirect_to bills_url
  end

end
