class Equipment < ApplicationRecord
  # Direct associations

  has_many   :equipment_comments,
             :dependent => :destroy

  belongs_to :lender

  # Indirect associations

  # Validations

end
