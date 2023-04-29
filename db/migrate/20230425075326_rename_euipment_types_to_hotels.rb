class RenameEuipmentTypesToHotels < ActiveRecord::Migration[6.1]
  def change
    rename_column :hotels, :euipment_types, :equipment
  end
end
