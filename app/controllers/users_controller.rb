class UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
    @location_hash = Gmaps4rails.build_markers(@users.where.not(:user_address_latitude => nil)) do |user, marker|
      marker.lat user.user_address_latitude
      marker.lng user.user_address_longitude
      marker.infowindow "<h5><a href='/users/#{user.id}'>#{user.email}</a></h5><small>#{user.user_address_formatted_address}</small>"
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
