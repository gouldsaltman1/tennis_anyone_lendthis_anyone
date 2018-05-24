class AddUserAddressLatitudeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :user_address_latitude, :float
  end
end
