class Api::CustomersController < ApplicationController

  require 'faceted'
  include Faceted::Controller
  respond_to :json
  
  def create
    @customer = Api::Customer.new(customer_params)
    @customer.save
    render_response @customer
  end

  def index
    @customers = Api::Customer.materialize(Customer.all)
    render_response_with_collection :customers, @customers
  end

  def show
    @customer = Api::Customer.new(id: params[:id])
    render_response @customer
  end

  private

  def customer_params
    params.require(:customer).permit(Customer.allowed_attributes)
  end

end