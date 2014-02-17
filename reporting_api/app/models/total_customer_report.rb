class TotalCustomerReport

  include PoroPlus

  attr_accessor :start_date, :end_date

  def self.from(date)
    report = new(start_date: date.beginning_of_day)
    report.log!
    report
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

  def to_hash
    {
      kind: self.class.name.underscore.humanize.titleize,
      start_date: self.start_date,
      end_date: self.end_date,
    }
  end

  def log!
    Leviathan.devour('Report Created', to_hash)
  end

end