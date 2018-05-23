require 'open-uri'
class Borrower < ApplicationRecord
  before_validation :geocode_address

  def geocode_address
    if self.address.present?
      url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(self.address)}"

      raw_data = open(url).read

      parsed_data = JSON.parse(raw_data)

      if parsed_data["results"].present?
        self.address_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

        self.address_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

        self.address_formatted_address = parsed_data["results"][0]["formatted_address"]
      end
    end
  end
  # Direct associations

  has_many   :lender_comments,
             :dependent => :destroy

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
