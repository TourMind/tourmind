class AddLockVersionToPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :lock_version, :integer, default: 0, null: false
  end
end
