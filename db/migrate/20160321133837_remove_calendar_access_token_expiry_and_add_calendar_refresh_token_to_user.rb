class RemoveCalendarAccessTokenExpiryAndAddCalendarRefreshTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :calendar_refresh_token, :string
    remove_column :users, :calendar_access_token_expiry, :string
  end
end
