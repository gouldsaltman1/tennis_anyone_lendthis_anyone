class EquipmentCommentsController < ApplicationController
  def index
    @q = EquipmentComment.ransack(params[:q])
    @equipment_comments = @q.result(:distinct => true).includes(:borrower, :piece_of_equipment).page(params[:page]).per(10)

    render("equipment_comments/index.html.erb")
  end

  def show
    @equipment_comment = EquipmentComment.find(params[:id])

    render("equipment_comments/show.html.erb")
  end

  def new
    @equipment_comment = EquipmentComment.new

    render("equipment_comments/new.html.erb")
  end

  def create
    @equipment_comment = EquipmentComment.new

    @equipment_comment.equipment_id = params[:equipment_id]
    @equipment_comment.borrower_id = params[:borrower_id]

    save_status = @equipment_comment.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/equipment_comments/new", "/create_equipment_comment"
        redirect_to("/equipment_comments")
      else
        redirect_back(:fallback_location => "/", :notice => "Equipment comment created successfully.")
      end
    else
      render("equipment_comments/new.html.erb")
    end
  end

  def edit
    @equipment_comment = EquipmentComment.find(params[:id])

    render("equipment_comments/edit.html.erb")
  end

  def update
    @equipment_comment = EquipmentComment.find(params[:id])

    @equipment_comment.equipment_id = params[:equipment_id]
    @equipment_comment.borrower_id = params[:borrower_id]

    save_status = @equipment_comment.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/equipment_comments/#{@equipment_comment.id}/edit", "/update_equipment_comment"
        redirect_to("/equipment_comments/#{@equipment_comment.id}", :notice => "Equipment comment updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Equipment comment updated successfully.")
      end
    else
      render("equipment_comments/edit.html.erb")
    end
  end

  def destroy
    @equipment_comment = EquipmentComment.find(params[:id])

    @equipment_comment.destroy

    if URI(request.referer).path == "/equipment_comments/#{@equipment_comment.id}"
      redirect_to("/", :notice => "Equipment comment deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Equipment comment deleted.")
    end
  end
end
