class CreateAvailabilityRanges < ActiveRecord::Migration
  def change
    create_table :availability_ranges do |t|
      t.date :start_date
      t.date :end_date
      t.references :desk, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
