class Widget < ActiveRecord::Base

  def self.allowed_attributes
    [:name, :description, :on_hand]
  end

  def self.create_or_update_from(params)
    return create(params).log!('Widget Created') unless params[:id].present?
    find(params.delete(:id)).update_attrbutes(params) && log!('Widget Updated')
  end

  def to_hash
    Widget.allowed_attributes.inject({}) do |h, attr|
      h[attr] = self.send(attr)
      h
    end
  end

  def log!(event_label)
    Leviathan.devour(event_label, self.to_hash)
    self
  end

end
