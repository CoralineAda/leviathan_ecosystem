class Api::WidgetsController < ApplicationController

  require 'faceted'
  include Faceted::Controller
  respond_to :json
  
  def create
    @widget = Api::Widget.new(widget_params)
    @widget.save
    render_response @widget
  end

  def index
    @widgets = Api::Widget.materialize(Widget.all)
    render_response_with_collection :widgets, @widgets
  end

  def show
    @widget = Api::Widget.new(id: params[:id])
    render_response @widget
  end

  private

  def widget_params
    params.require(:widget).permit(Widget.allowed_attributes)
  end

end