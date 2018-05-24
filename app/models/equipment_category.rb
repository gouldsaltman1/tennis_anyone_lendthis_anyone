class EquipmentCategory < ApplicationRecord
  # Direct associations

  has_many   :equipments,
             :dependent => :destroy

  # Indirect associations

  # Validations

end
