class WidgetRequestListener

  include Listener

  def queue_name
    "widget"
  end

  def process(params)
    Widget.create_or_update_from(params[queue_name])
  end

end