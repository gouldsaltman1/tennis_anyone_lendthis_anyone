class Loan < ApplicationRecord
  # Direct associations

  belongs_to :borrow,
             :class_name => "Borrower"

  # Indirect associations

  # Validations

end
