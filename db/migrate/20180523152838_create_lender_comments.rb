class CreateLenderComments < ActiveRecord::Migration
  def change
    create_table :lender_comments do |t|
      t.integer :lender_id
      t.integer :borrower_id

      t.timestamps

    end
  end
end
