class Equipment < ApplicationRecord
  mount_uploader :image, ImageUploader

  # Direct associations

  has_many   :loans,
             :dependent => :destroy

  has_many   :equipment_comments,
             :dependent => :destroy

  belongs_to :lender

  # Indirect associations

  # Validations

end
