class AddScrapedPhotosToHotels < ActiveRecord::Migration[6.1]
  def change
    add_column :hotels, :scraped_photo, :string
  end
end
