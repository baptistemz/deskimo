class ChangeOrderForBookingInPayments < ActiveRecord::Migration
  def change
    add_column :payments, :booking_id, :integer
    remove_column :payments, :order_id, :integer
  end
end
