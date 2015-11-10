class CreateWorkplaces < ActiveRecord::Migration
  def change
    create_table :workplaces do |t|
      t.string :address
      t.string :city
      t.string :postcode
      t.string :name
      t.text :description
      t.boolean :coffee
      t.boolean :wifi
      t.boolean :printer
      t.boolean :scanner
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
