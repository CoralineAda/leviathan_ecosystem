class CustomerListener

  include Listener

  def queue_name
    "customer"
  end

  def process(params)
    Customer.create_or_update_from(params[queue_name])
  end

end