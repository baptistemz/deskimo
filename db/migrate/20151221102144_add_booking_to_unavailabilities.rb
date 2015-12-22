class AddBookingToUnavailabilities < ActiveRecord::Migration
  def change
    add_reference :unavailability_ranges, :booking, index: true, foreign_key: true
  end
end
