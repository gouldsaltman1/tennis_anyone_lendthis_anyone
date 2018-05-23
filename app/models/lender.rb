require 'open-uri'
class Lender < ApplicationRecord
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

  has_many   :equipment,
             :dependent => :destroy

  has_many   :lender_comments,
             :dependent => :destroy

  # Indirect associations

  has_many   :loans,
             :through => :equipment,
             :source => :loans

  # Validations

end
