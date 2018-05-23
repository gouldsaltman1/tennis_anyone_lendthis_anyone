class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.integer :user_id
      t.integer :lender_id
      t.string :category
      t.string :price
      t.string :image
      t.datetime :time_available_start
      t.datetime :time_available_end

      t.timestamps

    end
  end
end
