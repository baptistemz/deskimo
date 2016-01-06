class MonetizeBookingAmount < ActiveRecord::Migration
  change_table :bookings do |t|
    t.monetize :amount, currency: { present: false }
  end
end
