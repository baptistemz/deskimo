class AddDefaultValueToDeskNumber < ActiveRecord::Migration
  def up
    change_column :desks, :number, :integer, :default => 1
  end

  def down
    change_column :desks, :number, :integer, :default => nil
  end
end
