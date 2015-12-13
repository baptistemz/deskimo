class AddMangopayWalletIdAndMangopayUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mangopay_wallet_id, :integer
    add_column :users, :mangopay_user_id, :integer
  end
end
