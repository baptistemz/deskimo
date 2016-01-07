class AddArchivedToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :archived, :boolean, :default => false
  end
end
