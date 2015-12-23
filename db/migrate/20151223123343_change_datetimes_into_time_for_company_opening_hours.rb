class ChangeDatetimesIntoTimeForCompanyOpeningHours < ActiveRecord::Migration
  def change
    remove_column :companies, :start_time_am, :datetime
    remove_column :companies, :end_time_am, :datetime
    remove_column :companies, :start_time_pm, :datetime
    remove_column :companies, :end_time_pm, :datetime
    add_column :companies, :start_time_am, :date
    add_column :companies, :end_time_am, :date
    add_column :companies, :start_time_pm, :date
    add_column :companies, :end_time_pm, :date
  end
end
