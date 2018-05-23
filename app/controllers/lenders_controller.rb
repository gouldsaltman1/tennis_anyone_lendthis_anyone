class LendersController < ApplicationController
  def index
    @q = Lender.ransack(params[:q])
    @lenders = @q.result(:distinct => true).includes(:lender_comments, :equipment, :loans).page(params[:page]).per(10)
    @location_hash = Gmaps4rails.build_markers(@lenders.where.not(:address_latitude => nil)) do |lender, marker|
      marker.lat lender.address_latitude
      marker.lng lender.address_longitude
      marker.infowindow "<h5><a href='/lenders/#{lender.id}'>#{lender.id}</a></h5><small>#{lender.address_formatted_address}</small>"
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

    @lender.first_name = params[:first_name]
    @lender.last_name = params[:last_name]
    @lender.email = params[:email]
    @lender.address = params[:address]

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

    @lender.first_name = params[:first_name]
    @lender.last_name = params[:last_name]
    @lender.email = params[:email]
    @lender.address = params[:address]

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
