class TotalCustomerReport

  include PoroPlus

  attr_accessor :start_date, :end_date, :total_customers

  def self.from(date)
    new(start_date: date.beginning_of_day)
  end

  def until(date)
    self.end_date = date.end_of_day
    self
  end

  def events
    @events = Event.customer_created.where(:created_at.gte => self.start_date, :created_at.lte => self.end_date)
  end

  def total_customers
    events.count
  end

end