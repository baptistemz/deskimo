class AddActivatedToDesks < ActiveRecord::Migration
  def change
    add_column :desks, :activated, :boolean
  end
end
