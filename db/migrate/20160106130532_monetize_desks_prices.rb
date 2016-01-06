class MonetizeDesksPrices < ActiveRecord::Migration
  change_table :desks do |t|
    t.monetize :hour_price, currency: { present: false }
    t.monetize :half_day_price, currency: { present: false }
    t.monetize :daily_price, currency: { present: false }
    t.monetize :weekly_price, currency: { present: false }
  end
end
