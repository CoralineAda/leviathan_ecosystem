class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :name
      t.text :description
      t.integer :on_hand, default: 0

      t.timestamps
    end
  end
end
