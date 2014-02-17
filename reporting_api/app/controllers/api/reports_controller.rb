class Api::ReportsController < ApplicationController

  require 'faceted'
  include Faceted::Controller
  respond_to :json
  
  def total_customers
    report = ::TotalCustomerReport.from(start_date).until(end_date)
    render_response Api::TotalCustomerReport.from(report)
  end

  private

  def start_date
    params[:start_date] || Time.zone.now - 1.day
  end 

  def end_date
    params[:end_date] || Time.zone.now + 1.day
  end

end