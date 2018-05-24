class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.string :address
      t.integer :user_id
      t.string :borrowing_address

      t.timestamps

    end
  end
end
