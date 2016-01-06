class RemoveMangopayAndAddStripeToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :mangopay_wallet_id, :integer
    remove_column :users, :mangopay_user_id, :integer
    add_column :users, :stripe_customer_id, :string
  end
end
