class AddOpeningDateTimesToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :open_monday, :boolean, default: false
    add_column :companies, :open_tuesday, :boolean, default: false
    add_column :companies, :open_wednesday, :boolean, default: false
    add_column :companies, :open_thursday, :boolean, default: false
    add_column :companies, :open_friday, :boolean, default: false
    add_column :companies, :open_saturday, :boolean, default: false
    add_column :companies, :open_sunday, :boolean, default: false
    add_column :companies, :open_holiday, :boolean, default: false
    add_column :companies, :start_time_am, :datetime
    add_column :companies, :end_time_am, :datetime
    add_column :companies, :start_time_pm, :datetime
    add_column :companies, :end_time_pm, :datetime
  end
end
