class RemoveAvailabilityRangesTable < ActiveRecord::Migration
  def change
    drop_table :availability_ranges
  end
end
