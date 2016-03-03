class AddCallConferenceToDesk < ActiveRecord::Migration
  def change
    add_column :desks, :call_conference, :boolean, :default => false
  end
end
