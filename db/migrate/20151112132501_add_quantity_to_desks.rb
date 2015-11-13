class AddQuantityToDesks < ActiveRecord::Migration
  def change
    add_column :desks, :quantity, :integer
  end
end
