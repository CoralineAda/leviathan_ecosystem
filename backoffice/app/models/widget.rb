class Widget

  include PoroPlus

  attr_accessor :name, :description, :quantity_available

  def self.all
    ApiConnector.synchronous.for(:widget).all
  end

  def sold_out?
    quantity_available == 0
  end

end