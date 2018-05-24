class AddAddressLatitudeToBorrower < ActiveRecord::Migration[5.0]
  def change
    add_column :borrowers, :address_latitude, :float
  end
end
