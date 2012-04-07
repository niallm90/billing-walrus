class BillsController < ApplicationController

  before_filter :authenticate_user!

  # GET /bills
  def index
    @bills = Bill.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bills }
    end
  end

  # GET /bills/1
  def show
    @bill = Bill.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bill }
    end
  end

  # GET /bills/new
  def new
    @bill = Bill.new
    format.html # new.html.erb
  end

  # GET /bills/1/edit
  def edit
    @bill = Bill.find(params[:id])
  end

  # POST /bills
  def create
    @bill = Bill.new(
      :issue_date => params[:issue_date],
      :due_date => params[:due_date]
    )
    @bill.vendor_id = params[:vendor]

    respond_to do |format|
      if @bill.save
        format.html { redirect_to @bill, notice: 'Bill was successfully created.' }
        format.json { render json: @bill }
      else
        flash.now[:warning] = "There was a problem creating the Bill. Please try again."
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
        format.html { redirect_to @bill, notice: "Bill was successfully updated." }
        format.json { render json: @bill }
      else
        flash.now[:warning] = "There was an error"
        format.html { render action: "edit" }
        format.json { render json: {"status" => "failure", "message" => "Bill was successfully updated." } }
      end
    end
  end

end
