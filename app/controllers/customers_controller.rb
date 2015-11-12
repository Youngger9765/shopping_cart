class CustomersController < ApplicationController

  before_action :find_customer, :only =>[:show, :destroy]

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def show
  end

  def create
    @customer = Customer.new(customer_params)
    @customer.save
    redirect_to customers_path
  end

  def destroy
    @customer.delete
    redirect_to customers_path
  end


  private

  def find_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:company, :company_tax_id, :name, :phone, :address)
  end

end
