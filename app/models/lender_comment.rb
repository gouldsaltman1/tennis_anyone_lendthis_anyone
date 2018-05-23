class LenderComment < ApplicationRecord
  # Direct associations

  belongs_to :lender

  belongs_to :borrower

  # Indirect associations

  # Validations

end
