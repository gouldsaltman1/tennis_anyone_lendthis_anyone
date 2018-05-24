class CreateEquipment < ActiveRecord::Migration
  def change
    create_table :equipment do |t|
      t.integer :user_id
      t.integer :lender_id
      t.string :price
      t.string :image
      t.datetime :time_available_start
      t.datetime :time_available_end
      t.integer :equipment_category_id
      t.string :name

      t.timestamps

    end
  end
end
