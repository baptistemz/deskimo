class AddWorkplacesColumnsToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :description, :text
    add_column :companies, :coffee, :boolean
    add_column :companies, :wifi, :boolean
    add_column :companies, :printer, :boolean
    add_column :companies, :scanner, :boolean
  end
end
