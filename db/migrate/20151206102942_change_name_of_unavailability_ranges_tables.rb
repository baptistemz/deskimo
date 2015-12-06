class ChangeNameOfUnavailabilityRangesTables < ActiveRecord::Migration
  def self.up
    rename_table :unavailability_ranges_tables, :unavailability_ranges
  end
  def self.down
    rename_table :unavailability_ranges, :unavailability_ranges_tables
  end
end
