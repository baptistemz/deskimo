class AddDefaultFalseToAdditionnalServices < ActiveRecord::Migration
  def up
    change_column :desks, :projector, :boolean, :default => false
    add_column :desks, :desktop, :boolean, :default => false
    add_column :desks, :tv, :boolean, :default => false
    remove_column :desks, :screen, :boolean
    remove_column :desks, :computer, :boolean
  end

  def down
    change_column :desks, :projector, :boolean, :default => nil
    remove_column :desks, :desktop, :boolean
    remove_column :desks, :tv, :boolean
    add_column :desks, :screen, :boolean
    add_column :desks, :computer, :boolean
  end
end
