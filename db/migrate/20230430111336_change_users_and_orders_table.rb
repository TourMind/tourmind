class ChangeUsersAndOrdersTable < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :diamond_grade, :string, :default => '一般會員'
    add_column :orders, :user_id, :integer
  end
end
