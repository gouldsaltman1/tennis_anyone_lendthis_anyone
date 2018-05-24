class AddUserAddressFormattedAddressToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_address_formatted_address, :string
  end
end
