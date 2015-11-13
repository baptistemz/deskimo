class ChangeTypeIntoKindFromDesks < ActiveRecord::Migration
  def change
    remove_column :desks, :type, :string
    add_column :desks, :kind, :string
  end
end
