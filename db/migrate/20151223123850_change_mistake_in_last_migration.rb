class ChangeMistakeInLastMigration < ActiveRecord::Migration
  def change
    remove_column :companies, :start_time_am, :date
    remove_column :companies, :end_time_am, :date
    remove_column :companies, :start_time_pm, :date
    remove_column :companies, :end_time_pm, :date
    add_column :companies, :start_time_am, :time
    add_column :companies, :end_time_am, :time
    add_column :companies, :start_time_pm, :time
    add_column :companies, :end_time_pm, :time
  end
end
