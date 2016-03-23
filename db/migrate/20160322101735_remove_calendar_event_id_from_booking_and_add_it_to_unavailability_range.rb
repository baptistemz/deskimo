class RemoveCalendarEventIdFromBookingAndAddItToUnavailabilityRange < ActiveRecord::Migration
  def change
    add_column :unavailability_ranges, :calendar_event_id, :string
    remove_column :bookings, :calendar_event_id, :string
  end
end
