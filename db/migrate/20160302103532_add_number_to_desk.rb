class AddNumberToDesk < ActiveRecord::Migration
  def change
    add_column :desks, :number, :integer
  end
end
