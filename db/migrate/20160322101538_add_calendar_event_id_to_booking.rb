class AddCalendarEventIdToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :calendar_event_id, :string
  end
end
