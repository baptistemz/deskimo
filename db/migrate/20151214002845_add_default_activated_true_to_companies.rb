class AddDefaultActivatedTrueToCompanies < ActiveRecord::Migration
  def up
    change_column_default :companies, :activated, true
  end

  def down
    change_column_default :companies, :activated, false
  end
end
