class WidgetRequest < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name
  
  after_create :log!

  def self.allowed_attributes
    [:name]
  end

  def log!
    return unless self.logging_enabled
    Leviathan.devour(:customer)
  end

end
