class Customer < ActiveRecord::Base

  validates_presence_of :email
  validates_uniqueness_of :email
  
  def self.allowed_attributes
    [:first_name, :last_name, :email, :phone, :preferred_contact, :postal_code]
  end

  def self.converted
    where.not(converted_at: nil)
  end

  def self.unconverted
    where(converted_at: nil)
  end

  def self.create_or_update_from(params)
    return create(params) unless params[:id].present?
    find(params.delete(:id)).update_attrbutes(params)
  end

end
