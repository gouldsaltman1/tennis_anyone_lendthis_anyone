class AddEquipmentCommentCountToEquipment < ActiveRecord::Migration[5.0]
  def change
    add_column :equipment, :equipment_comments_count, :integer
  end
end
