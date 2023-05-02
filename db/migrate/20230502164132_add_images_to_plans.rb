class AddImagesToPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :images, :json
  end
end
