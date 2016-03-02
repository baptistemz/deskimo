class AddCapacityToDesk < ActiveRecord::Migration
  def change
    add_column :desks, :capacity, :integer
  end
end
