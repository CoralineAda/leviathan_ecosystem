class Signup

  include ActiveModel::Model
  include PoroPlus

  attr_accessor :email, :errors

  def valid?
    ! self.errors.present?
  end

  def saved?
    valid? && self.email.present?
  end

  def new?
    self.errors.nil? 
  end

  def save
    self.errors = ApiConnector.synchronous.for(:customer).with(self.to_hash).save.errors
    saved?
  end

  def message
    valid? && "Enter your email" || "Invalid or existing email"
  end

  def to_hash
    p self.email
    {email: self.email}
  end

  def persisted?
    false
  end

end