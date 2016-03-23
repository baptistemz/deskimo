class AddCalendarAccessTokenExpiryToUser < ActiveRecord::Migration
  def change
    add_column :users, :calendar_access_token_expiry, :string
  end
end
