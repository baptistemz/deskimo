class CreateWelcomeMessages < ActiveRecord::Migration
  def change
    create_table :welcome_messages do |t|
      t.text :message
      t.string :wifi_name
      t.string :wifi_password
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
