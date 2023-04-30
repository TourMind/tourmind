class RenamePaymentsToOrders < ActiveRecord::Migration[6.1]
  def change
    rename_table :payments, :orders
  end
end
