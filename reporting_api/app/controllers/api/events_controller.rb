class Api::EventsController < ApplicationController

  require 'faceted'
  include Faceted::Controller
  respond_to :json

  def index
    events = params[:filter].present? && ::Event.where(params[:filter]) || ::Event.all
    respond_with Api::Event.materialize(events)
  end

end