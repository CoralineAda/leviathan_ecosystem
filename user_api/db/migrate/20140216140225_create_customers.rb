class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.datetime :converted_at
      t.string :preferred_contact
      t.string :phone
      t.string :postal_code

      t.timestamps
    end
  end
end
