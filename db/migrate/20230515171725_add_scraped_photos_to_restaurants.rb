class AddScrapedPhotosToRestaurants < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :scraped_photos, :json
  end
end
