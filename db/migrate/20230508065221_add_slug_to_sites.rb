class AddSlugToSites < ActiveRecord::Migration[6.1]
  def change
    add_column :sites, :slug, :string
    add_index :sites, :slug, unique: true
  end
end
