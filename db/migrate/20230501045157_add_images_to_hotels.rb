class AddImagesToHotels < ActiveRecord::Migration[6.1]
  def change
    add_column :hotels, :images, :json
  end
end
