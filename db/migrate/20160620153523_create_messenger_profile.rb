class CreateMessengerProfile < ActiveRecord::Migration
  def change
    create_table :messenger_profiles do |t|
      t.references :user, index: true, foreign_key: true
      t.string :messenger_id
      t.string :first_name
      t.string :last_name
      t.string :profile_pic_url
      t.string :locale
      t.integer :timezone
      t.string :gender
    end
  end
end
