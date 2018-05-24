require 'open-uri'
class Lender < ApplicationRecord
  before_validation :geocode_lending_address

  def geocode_lending_address
    if self.lending_address.present?
      url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(self.lending_address)}"

      raw_data = open(url).read

      parsed_data = JSON.parse(raw_data)

      if parsed_data["results"].present?
        self.lending_address_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

        self.lending_address_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

        self.lending_address_formatted_address = parsed_data["results"][0]["formatted_address"]
      end
    end
  end
  # Direct associations

  belongs_to :user

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
