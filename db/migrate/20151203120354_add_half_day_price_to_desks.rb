class AddHalfDayPriceToDesks < ActiveRecord::Migration
  def change
    add_column :desks, :half_day_price, :integer
  end
end
