require 'open-uri'
class User < ApplicationRecord
  before_validation :geocode_user_address

  def geocode_user_address
    if self.user_address.present?
      url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(self.user_address)}"

      raw_data = open(url).read

      parsed_data = JSON.parse(raw_data)

      if parsed_data["results"].present?
        self.user_address_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

        self.user_address_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

        self.user_address_formatted_address = parsed_data["results"][0]["formatted_address"]
      end
    end
  end
  # Direct associations

  has_one    :lender_id,
             :class_name => "Lender",
             :dependent => :destroy

  has_one    :borrower_id,
             :class_name => "Borrower",
             :dependent => :destroy

  # Indirect associations

  # Validations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
