require 'open-uri'
class Borrower < ApplicationRecord
  before_validation :geocode_borrowing_address

  def geocode_borrowing_address
    if self.borrowing_address.present?
      url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(self.borrowing_address)}"

      raw_data = open(url).read

      parsed_data = JSON.parse(raw_data)

      if parsed_data["results"].present?
        self.borrowing_address_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

        self.borrowing_address_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

        self.borrowing_address_formatted_address = parsed_data["results"][0]["formatted_address"]
      end
    end
  end
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

  belongs_to :user

  has_many   :lender_comments,
             :dependent => :destroy

  has_many   :equipment_comments,
             :dependent => :destroy

  has_many   :loans,
             :foreign_key => "borrow_id",
             :dependent => :destroy

  # Indirect associations

  # Validations

end
