class CreateClosingDays < ActiveRecord::Migration
  def change
    create_table :closing_days do |t|
      t.date :date
      t.references :company, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
