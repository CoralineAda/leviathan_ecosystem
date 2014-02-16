class WidgetRequestListener

  include Listener

  def queue_name
    "widget_request"
  end

  def process(params)
    WidgetRequest.create(params[queue_name])
  end

end