class AddBorrowingAddressFormattedAddressToBorrower < ActiveRecord::Migration[5.0]
  def change
    add_column :borrowers, :borrowing_address_formatted_address, :string
  end
end
