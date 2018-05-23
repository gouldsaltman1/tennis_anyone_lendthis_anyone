class AddLoanCountToEquipment < ActiveRecord::Migration[5.0]
  def change
    add_column :equipment, :loans_count, :integer
  end
end
