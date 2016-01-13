class Addpaymentandusertoinvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :payment, :json
    add_reference :invoices, :user, index: true, foreign_key: true
  end
end
