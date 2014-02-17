class Api::MetaReport

  include Faceted::Presenter

  presents :meta_report

  field :start_date
  field :end_date
  field :reports

end