class RemoveWorkplacesAndAddCompaniesToDesks < ActiveRecord::Migration
  def change
    remove_reference :desks, :workplace, index: true, foreign_key: true
    add_reference :desks, :company, index: true, foreign_key: true
  end
end
