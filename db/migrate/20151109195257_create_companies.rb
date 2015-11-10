class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :siret
      t.string :address
      t.string :city
      t.string :postcode

      t.timestamps null: false
    end
  end
end
