class ChangeDateTimesAndAddHalfDayChoiceToBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :start_date_time, :datetime
    remove_column :bookings, :end_date_time, :datetime
    add_column :bookings, :start_date, :date
    add_column :bookings, :end_date, :date
    add_column :bookings, :half_day_choice, :string
  end
end
