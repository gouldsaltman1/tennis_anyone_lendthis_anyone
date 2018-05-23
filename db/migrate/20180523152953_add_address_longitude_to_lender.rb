class AddAddressLongitudeToLender < ActiveRecord::Migration[5.0]
  def change
    add_column :lenders, :address_longitude, :float
  end
end
