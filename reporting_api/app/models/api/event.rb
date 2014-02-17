class Api::Event

  include Faceted::Presenter

  presents :event

  field :label
  field :details
  field :date

  def date
    event.created_at
  end

end