class ChangeRestaurantTypeToString < ActiveRecord::Migration[6.1]
  def up
    change_column :restaurants, :restaurant_type, :string
  end

  def down
    change_column :restaurants, :restaurant_type, :integer
  end
end
