class RemoveSeperateAndAddTypeToDesks < ActiveRecord::Migration
  def change
    add_column :desks, :type, :string
    remove_column :desks, :seperate, :boolean
  end
end
