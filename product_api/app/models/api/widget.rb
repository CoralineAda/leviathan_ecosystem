class Api::Widget

  include Faceted::Presenter

  presents :widget

  field :name
  field :description
  field :on_hand
  field :out_of_stock?

  def out_of_stock?
    widget.on_hand == 0
  end

end