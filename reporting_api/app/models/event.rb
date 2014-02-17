class Event

  include Mongoid::Document
  include Mongoid::Timestamps

  field :label
  field :details, type: Hash

  def self.customer_created
    where(label: "Customer Created")
  end

  def self.report_created
    where(label: "Report Created")
  end
  
  
end