class WidgetRequest < ActiveRecord::Base

  validates_presence_of :name
  validates_uniqueness_of :name
  
  def self.allowed_attributes
    [:name]
  end

end
