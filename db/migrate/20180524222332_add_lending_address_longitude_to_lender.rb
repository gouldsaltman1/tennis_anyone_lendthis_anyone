class AddLendingAddressLongitudeToLender < ActiveRecord::Migration[5.0]
  def change
    add_column :lenders, :lending_address_longitude, :float
  end
end
