class AddDefaultActivatedToDesks < ActiveRecord::Migration
  def up
    change_column_default :desks, :activated, true
  end

  def down
    change_column_default :desks, :activated, nil
  end
end
