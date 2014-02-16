class Api::Customer

  include Faceted::Presenter

  presents :customer

  field :first_name
  field :last_name
  field :email
  field :phone
  field :preferred_contact
  field :postal_code
  field :converted?

  def converted?
    customer.converted_at.present?
  end

end