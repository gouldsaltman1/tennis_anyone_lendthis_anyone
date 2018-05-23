class CreateEquipmentComments < ActiveRecord::Migration
  def change
    create_table :equipment_comments do |t|
      t.integer :equipment_id
      t.integer :borrower_id

      t.timestamps

    end
  end
end
