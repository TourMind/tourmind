class AddImagesToSites < ActiveRecord::Migration[6.1]
  def change
    add_column :sites, :images, :json
  end
end
