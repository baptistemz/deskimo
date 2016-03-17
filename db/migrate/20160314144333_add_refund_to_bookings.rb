class AddRefundToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :refund, :json
  end
end
