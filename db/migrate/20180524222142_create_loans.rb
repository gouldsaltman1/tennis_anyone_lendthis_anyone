class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :borrow_id
      t.integer :lender_id
      t.string :borrower_lender_equipment
      t.integer :equipment_id

      t.timestamps

    end
  end
end
