class AddAddressFormattedAddressToLender < ActiveRecord::Migration[5.0]
  def change
    add_column :lenders, :address_formatted_address, :string
  end
end
