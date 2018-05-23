class EquipmentComment < ApplicationRecord
  # Direct associations

  belongs_to :piece_of_equipment,
             :class_name => "Equipment",
             :foreign_key => "equipment_id",
             :counter_cache => true

  belongs_to :borrower

  # Indirect associations

  # Validations

end
