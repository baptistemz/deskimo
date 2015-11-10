class CreateDesks < ActiveRecord::Migration
  def change
    create_table :desks do |t|
      t.boolean :seperate
      t.text :description
      t.references :workplace, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
