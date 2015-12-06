class AddKindToUnavailabilityRanges < ActiveRecord::Migration
  def change
    add_column :unavailability_ranges, :kind, :string
  end
end
