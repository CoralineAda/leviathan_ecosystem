class Signup

  include ActiveModel::Model
  include PoroPlus

  attr_accessor :email, :first_name, :last_name, :postal_code, :errors

  def self.total_today
    results = ApiConnector.synchronous.for(:signup_today).get(:one)
    results['response'].fetch('total_customers', 2)
  end

  def valid?
    email.present? && postal_code.present? && (self.errors.nil? || self.errors.blank?)
  end

  def saved?
    valid?
  end

  def new?
    self.errors.nil? 
  end

  def save
    self.errors = ApiConnector.asynchronous.for(:customer).with(self.to_hash).save.errors
    saved?
  end

  def message
    valid? && "Enter your email" || "Invalid or existing email"
  end

  def to_hash
    {
      customer: {
        first_name: self.first_name,
        last_name: self.last_name,
        email: self.email
      }
    }
  end

  def persisted?
    false
  end

end