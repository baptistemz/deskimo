class AddStartDatetimeEndDatetimeTimeSlotQuantityTimeSlotTypeToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :time_slot_quantity, :integer
    add_column :bookings, :time_slot_type, :string
  end
end
