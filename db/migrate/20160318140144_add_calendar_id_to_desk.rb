class AddCalendarIdToDesk < ActiveRecord::Migration
  def change
    add_column :desks, :calendar_id, :string
  end
end
