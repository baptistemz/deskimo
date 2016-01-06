class MonetizePaymentAmount < ActiveRecord::Migration
  change_table :payments do |t|
    t.remove :amount_cents
    t.remove :amount_currency
    t.monetize :amount, currency: { present: false }
  end
end
