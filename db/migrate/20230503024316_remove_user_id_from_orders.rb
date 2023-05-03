class RemoveUserIdFromOrders < ActiveRecord::Migration[6.1]
  def change
    def up
      remove_column :orders, :user_id
    end
    
    def down
      add_column :orders, :user_id, :integer
    end
  end
end
