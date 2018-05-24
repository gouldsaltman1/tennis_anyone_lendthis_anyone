class AddBorrowingAddressLongitudeToBorrower < ActiveRecord::Migration[5.0]
  def change
    add_column :borrowers, :borrowing_address_longitude, :float
  end
end
