class AddCheapestDeskPriceToCompany < ActiveRecord::Migration
  change_table :companies do |t|
    t.monetize :cheapest_desk_price, currency: { present: false }
  end
end
