class AddUserToPlans < ActiveRecord::Migration[6.1]
  def change
    add_reference :plans, :user, foreign_key: true
    add_column :plans, :people, :integer, default: 1
    add_column :plans, :public, :boolean, default: false
    change_column_default :plans, :images, []
  end
end
