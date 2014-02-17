class MetaReport

  include PoroPlus

  attr_accessor :start_date, :end_date

  def self.from(date)
    new(start_date: date.beginning_of_day)
  end

  def until(date)
    self.end_date = date.end_of_day
    self
  end

  def events
    @events = Event.report_created.where(:created_at.gte => self.start_date, :created_at.lte => self.end_date)
  end

  def reports
    events.group_by{|e| e.details['kind']}.inject({}) do |h,pair|
      h[pair[0]] = pair[1].count
      h
    end
  end

end