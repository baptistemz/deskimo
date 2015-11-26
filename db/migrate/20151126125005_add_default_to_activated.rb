class AddDefaultToActivated < ActiveRecord::Migration
  def change
    def up
      change_column :desks, :activated, :boolean, :default => true
    end

    def down
      change_column :desks, :activated, :boolean, :default => nil
    end
  end
end
