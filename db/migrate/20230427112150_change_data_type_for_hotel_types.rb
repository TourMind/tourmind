class ChangeDataTypeForHotelTypes < ActiveRecord::Migration[6.1]
  def change
    change_column :hotels, :hotel_types, :string, default: nil, array: false
  end
end
