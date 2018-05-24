class EquipmentCategoriesController < ApplicationController
  def index
    @q = EquipmentCategory.ransack(params[:q])
    @equipment_categories = @q.result(:distinct => true).includes(:equipments).page(params[:page]).per(10)

    render("equipment_categories/index.html.erb")
  end

  def show
    @equipment = Equipment.new
    @equipment_category = EquipmentCategory.find(params[:id])

    render("equipment_categories/show.html.erb")
  end

  def new
    @equipment_category = EquipmentCategory.new

    render("equipment_categories/new.html.erb")
  end

  def create
    @equipment_category = EquipmentCategory.new

    @equipment_category.category_name = params[:category_name]

    save_status = @equipment_category.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/equipment_categories/new", "/create_equipment_category"
        redirect_to("/equipment_categories")
      else
        redirect_back(:fallback_location => "/", :notice => "Equipment category created successfully.")
      end
    else
      render("equipment_categories/new.html.erb")
    end
  end

  def edit
    @equipment_category = EquipmentCategory.find(params[:id])

    render("equipment_categories/edit.html.erb")
  end

  def update
    @equipment_category = EquipmentCategory.find(params[:id])

    @equipment_category.category_name = params[:category_name]

    save_status = @equipment_category.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/equipment_categories/#{@equipment_category.id}/edit", "/update_equipment_category"
        redirect_to("/equipment_categories/#{@equipment_category.id}", :notice => "Equipment category updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Equipment category updated successfully.")
      end
    else
      render("equipment_categories/edit.html.erb")
    end
  end

  def destroy
    @equipment_category = EquipmentCategory.find(params[:id])

    @equipment_category.destroy

    if URI(request.referer).path == "/equipment_categories/#{@equipment_category.id}"
      redirect_to("/", :notice => "Equipment category deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Equipment category deleted.")
    end
  end
end
