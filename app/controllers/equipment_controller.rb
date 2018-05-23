class EquipmentController < ApplicationController
  def index
    @q = Equipment.ransack(params[:q])
    @equipment = @q.result(:distinct => true).includes(:lender, :equipment_comments, :loans).page(params[:page]).per(10)

    render("equipment/index.html.erb")
  end

  def show
    @loan = Loan.new
    @equipment_comment = EquipmentComment.new
    @equipment = Equipment.find(params[:id])

    render("equipment/show.html.erb")
  end

  def new
    @equipment = Equipment.new

    render("equipment/new.html.erb")
  end

  def create
    @equipment = Equipment.new

    @equipment.user_id = params[:user_id]
    @equipment.lender_id = params[:lender_id]
    @equipment.category = params[:category]
    @equipment.price = params[:price]
    @equipment.image = params[:image]
    @equipment.time_available_start = params[:time_available_start]
    @equipment.time_available_end = params[:time_available_end]

    save_status = @equipment.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/equipment/new", "/create_equipment"
        redirect_to("/equipment")
      else
        redirect_back(:fallback_location => "/", :notice => "Equipment created successfully.")
      end
    else
      render("equipment/new.html.erb")
    end
  end

  def edit
    @equipment = Equipment.find(params[:id])

    render("equipment/edit.html.erb")
  end

  def update
    @equipment = Equipment.find(params[:id])

    @equipment.user_id = params[:user_id]
    @equipment.lender_id = params[:lender_id]
    @equipment.category = params[:category]
    @equipment.price = params[:price]
    @equipment.image = params[:image]
    @equipment.time_available_start = params[:time_available_start]
    @equipment.time_available_end = params[:time_available_end]

    save_status = @equipment.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/equipment/#{@equipment.id}/edit", "/update_equipment"
        redirect_to("/equipment/#{@equipment.id}", :notice => "Equipment updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Equipment updated successfully.")
      end
    else
      render("equipment/edit.html.erb")
    end
  end

  def destroy
    @equipment = Equipment.find(params[:id])

    @equipment.destroy

    if URI(request.referer).path == "/equipment/#{@equipment.id}"
      redirect_to("/", :notice => "Equipment deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Equipment deleted.")
    end
  end
end
