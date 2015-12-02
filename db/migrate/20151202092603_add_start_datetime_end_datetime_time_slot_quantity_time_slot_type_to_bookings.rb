class AddStartDatetimeEndDatetimeTimeSlotQuantityTimeSlotTypeToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :start_date_time, :datetime
    add_column :bookings, :end_date_time, :datetime
    add_column :bookings, :time_slot_quantity, :integer
    add_column :bookings, :time_slot_type, :string
  end
end
