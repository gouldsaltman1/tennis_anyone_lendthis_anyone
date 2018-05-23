class AddAddressLongitudeToBorrower < ActiveRecord::Migration[5.0]
  def change
    add_column :borrowers, :address_longitude, :float
  end
end
