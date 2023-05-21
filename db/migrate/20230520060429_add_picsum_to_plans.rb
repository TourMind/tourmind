class AddPicsumToPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :picsums, :json
  end
end
