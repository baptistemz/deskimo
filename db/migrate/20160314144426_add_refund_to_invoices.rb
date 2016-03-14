class AddRefundToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :refund, :json
  end
end
