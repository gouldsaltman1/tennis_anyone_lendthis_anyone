class AddBorrowingAddressLatitudeToBorrower < ActiveRecord::Migration[5.0]
  def change
    add_column :borrowers, :borrowing_address_latitude, :float
  end
end
