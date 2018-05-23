class Borrower < ApplicationRecord
  # Direct associations

  has_many   :equipment_comments,
             :dependent => :destroy

  has_many   :loans,
             :foreign_key => "borrow_id",
             :dependent => :destroy

  # Indirect associations

  # Validations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
