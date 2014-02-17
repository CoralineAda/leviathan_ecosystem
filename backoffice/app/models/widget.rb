class Widget

  include PoroPlus

  attr_accessor :name, :description, :on_hand

  def self.all
    ApiConnector.synchronous.for(:widget).all.map{|h| new(h)}
  end

  def sold_out?
    quantity_available == 0
  end

end