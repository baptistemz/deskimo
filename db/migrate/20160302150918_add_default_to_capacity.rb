class AddDefaultToCapacity < ActiveRecord::Migration
  def up
    change_column :desks, :capacity, :integer, :default => 1
  end

  def down
    change_column :desks, :capacity, :integer, :default => nil
  end
end
