class RemoveSectionMichelinStarColumnsAddImages < ActiveRecord::Migration[6.1]
  def change
    remove_column :restaurants, :section, :string
    remove_column :restaurants, :michelin_star, :string
    add_column :restaurants, :images, :json
  end
end
