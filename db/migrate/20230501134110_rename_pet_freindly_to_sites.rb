class RenamePetFreindlyToSites < ActiveRecord::Migration[6.1]
  def change
    rename_column :sites, :pet_freindly, :pet_friendly
  end
end
