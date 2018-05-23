class AddAddressLatitudeToLender < ActiveRecord::Migration[5.0]
  def change
    add_column :lenders, :address_latitude, :float
  end
end
