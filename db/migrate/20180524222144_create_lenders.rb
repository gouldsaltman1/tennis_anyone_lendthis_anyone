class CreateLenders < ActiveRecord::Migration
  def change
    create_table :lenders do |t|
      t.string :lending_address
      t.integer :user_id

      t.timestamps

    end
  end
end
