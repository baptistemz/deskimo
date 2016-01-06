class AddPaymentToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :payment, :json
  end
end
