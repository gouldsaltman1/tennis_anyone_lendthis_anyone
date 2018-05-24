class AddLendingAddressFormattedAddressToLender < ActiveRecord::Migration[5.0]
  def change
    add_column :lenders, :lending_address_formatted_address, :string
  end
end
