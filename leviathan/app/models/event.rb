class Event

  include Mongoid::Document
  include Mongoid::Timestamps

  field :label
  field :details, type: Hash

  def self.from(json)
    data = JSON.parse(json)
    p data
    create(label: data.delete('event'), details: data)
  end
  
end