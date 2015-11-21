class RemoveDeviseFromCompany < ActiveRecord::Migration
  def change
    remove_column :companies, :email, :string
    remove_column :companies, :encrypted_password, :string
    remove_column :companies, :reset_password_token, :string
    remove_column :companies, :reset_password_sent_at, :datetime
    remove_column :companies, :remember_created_at, :datetime
    remove_column :companies, :sign_in_count, :integer
    remove_column :companies, :current_sign_in_at, :datetime
    remove_column :companies, :last_sign_in_at, :datetime
    remove_column :companies, :current_sign_in_ip, :inet
    remove_column :companies, :last_sign_in_ip, :inet
      ## Database authenticatable

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end


    # add_index :companies, :confirmation_token,   unique: true
    # add_index :companies, :unlock_token,         unique: true

end
