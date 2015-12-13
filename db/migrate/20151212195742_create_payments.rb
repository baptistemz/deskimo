class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :payer_id
      t.integer :receiver_id
      t.integer :credit_card_id
      t.integer :amount_cents, default: 0
      t.string  :amount_currency, default: 'EUR'
      t.json    :response
      t.string  :status
      t.string  :mangopay_payin_id
      t.integer :order_id
      t.timestamps null: false
    end
  end
end
