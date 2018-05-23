class BorrowersController < ApplicationController
  def index
    @borrowers = Borrower.page(params[:page]).per(10)
    @location_hash = Gmaps4rails.build_markers(@borrowers.where.not(:address_latitude => nil)) do |borrower, marker|
      marker.lat borrower.address_latitude
      marker.lng borrower.address_longitude
      marker.infowindow "<h5><a href='/borrowers/#{borrower.id}'>#{borrower.created_at}</a></h5><small>#{borrower.address_formatted_address}</small>"
    end
  end

  def show
    @borrower = Borrower.find(params[:id])
  end
end
