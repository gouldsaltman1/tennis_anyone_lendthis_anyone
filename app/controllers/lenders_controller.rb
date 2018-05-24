class LendersController < ApplicationController
  before_action :current_user_must_be_lender_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_lender_user
    lender = Lender.find(params[:id])

    unless current_user == lender.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = Lender.ransack(params[:q])
    @lenders = @q.result(:distinct => true).includes(:lender_comments, :equipment, :user, :loans).page(params[:page]).per(10)
    @location_hash = Gmaps4rails.build_markers(@lenders.where.not(:lending_address_latitude => nil)) do |lender, marker|
      marker.lat lender.lending_address_latitude
      marker.lng lender.lending_address_longitude
      marker.infowindow "<h5><a href='/lenders/#{lender.id}'>#{lender.id}</a></h5><small>#{lender.lending_address_formatted_address}</small>"
    end

    render("lenders/index.html.erb")
  end

  def show
    @equipment = Equipment.new
    @lender_comment = LenderComment.new
    @lender = Lender.find(params[:id])

    render("lenders/show.html.erb")
  end

  def new
    @lender = Lender.new

    render("lenders/new.html.erb")
  end

  def create
    @lender = Lender.new

    @lender.lending_address = params[:lending_address]
    @lender.user_id = params[:user_id]

    save_status = @lender.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/lenders/new", "/create_lender"
        redirect_to("/lenders")
      else
        redirect_back(:fallback_location => "/", :notice => "Lender created successfully.")
      end
    else
      render("lenders/new.html.erb")
    end
  end

  def edit
    @lender = Lender.find(params[:id])

    render("lenders/edit.html.erb")
  end

  def update
    @lender = Lender.find(params[:id])

    @lender.lending_address = params[:lending_address]
    @lender.user_id = params[:user_id]

    save_status = @lender.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/lenders/#{@lender.id}/edit", "/update_lender"
        redirect_to("/lenders/#{@lender.id}", :notice => "Lender updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Lender updated successfully.")
      end
    else
      render("lenders/edit.html.erb")
    end
  end

  def destroy
    @lender = Lender.find(params[:id])

    @lender.destroy

    if URI(request.referer).path == "/lenders/#{@lender.id}"
      redirect_to("/", :notice => "Lender deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Lender deleted.")
    end
  end
end
