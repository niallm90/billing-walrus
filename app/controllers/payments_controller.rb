class PaymentsController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!

  # GET /payments
  def index
    @payments = Payment.all

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /payments/1
  def show
    @payment = Payment.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /payments/new
  def new
    @payment = Payment.new(:slice_id => params[:slice_id])
  end

  # GET /payments/1/edit
  def edit
    @payment = Payment.find(params[:id])
  end

  # POST /payments
  def create
    @payment = Payment.new(params[:payment])

    respond_to do |format|
      if @payment.save
        flash[:notice] = 'Payment was successfully created.'
        format.html { redirect_to slice_url(@payment.slice.bill, @payment.slice) }
      else
        flash[:warning] = "There was a problem creating the Payment. Please try again."
        format.html { render action: "new" }
        format.json { render json: {"status" => "failure", "message" => "There was a problem creating the Payment. Please try again."} }
      end
    end
  end

  # PUT /payments/1
  def update
    @payment = Payment.find(params[:id])

    respond_to do |format|
      if @payment.update_attributes!(params[:payment])
        flash[:notice] = 'Payment was successfully updated.'
        format.html { redirect_to [@payment.slice, @payment] }
      else
        flash[:warning] = "There was an error"
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment = Payment.find(params[:id])
    slice = @payment.slice
    @payment.destroy
    redirect_to slice_url(slice.bill, slice)
  end
end
