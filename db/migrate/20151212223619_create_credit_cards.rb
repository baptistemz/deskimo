class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string :name
      t.date   :expires_at
      t.string :token
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
