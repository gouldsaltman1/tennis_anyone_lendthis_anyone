class AddLendingAddressLatitudeToLender < ActiveRecord::Migration[5.0]
  def change
    add_column :lenders, :lending_address_latitude, :float
  end
end
