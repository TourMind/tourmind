class AddScrapedPhotosToSites < ActiveRecord::Migration[6.1]
  def change
    add_column :sites, :scraped_photos, :json
  end
end