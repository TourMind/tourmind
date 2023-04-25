class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :hotels, :equipment_types, :equipment
  end
end
