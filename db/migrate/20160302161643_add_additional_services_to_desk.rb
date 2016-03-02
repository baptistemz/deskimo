class AddAdditionalServicesToDesk < ActiveRecord::Migration
  def change
    add_column :desks, :projector, :boolean
    add_column :desks, :screen, :boolean
    add_column :desks, :computer, :boolean
    add_column :desks, :paperboard, :boolean
  end
end
