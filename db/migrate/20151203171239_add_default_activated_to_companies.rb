class AddDefaultActivatedToCompanies < ActiveRecord::Migration
  def up
    change_column_default :companies, :activated, false
  end

  def down
    change_column_default :companies, :activated, nil
  end
end
