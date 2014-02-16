class CustomerListener

  include Listener

  def queue_name
    "customer"
  end

  def process(params)
    Customer.create!(params[queue_name])
  end

end