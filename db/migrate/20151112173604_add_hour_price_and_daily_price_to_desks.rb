class AddHourPriceAndDailyPriceToDesks < ActiveRecord::Migration
  def change
    add_column :desks, :hour_price, :integer
    add_column :desks, :daily_price, :integer
    add_column :desks, :weekly_price, :integer
  end
end
