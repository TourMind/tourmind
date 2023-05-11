class AddUsersSessionsRole < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role, :integer, :default => 1
    #  0: 管理員, 1: 會員
  end
end
