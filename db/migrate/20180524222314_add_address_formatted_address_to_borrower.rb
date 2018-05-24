class AddAddressFormattedAddressToBorrower < ActiveRecord::Migration[5.0]
  def change
    add_column :borrowers, :address_formatted_address, :string
  end
end
