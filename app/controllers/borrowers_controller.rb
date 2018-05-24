class BorrowersController < ApplicationController
  before_action :current_user_must_be_borrower_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_borrower_user
    borrower = Borrower.find(params[:id])

    unless current_user == borrower.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @borrowers = [current_user.borrower_id]

    render("borrowers/index.html.erb")
  end

  def show
    @lender_comment = LenderComment.new
    @equipment_comment = EquipmentComment.new
    @loan = Loan.new
    @borrower = Borrower.find(params[:id])

    render("borrowers/show.html.erb")
  end

  def new
    @borrower = Borrower.new

    render("borrowers/new.html.erb")
  end

  def create
    @borrower = Borrower.new

    @borrower.address = params[:address]
    @borrower.user_id = params[:user_id]
    @borrower.borrowing_address = params[:borrowing_address]

    save_status = @borrower.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/borrowers/new", "/create_borrower"
        redirect_to("/borrowers")
      else
        redirect_back(:fallback_location => "/", :notice => "Borrower created successfully.")
      end
    else
      render("borrowers/new.html.erb")
    end
  end

  def edit
    @borrower = Borrower.find(params[:id])

    render("borrowers/edit.html.erb")
  end

  def update
    @borrower = Borrower.find(params[:id])

    @borrower.address = params[:address]
    @borrower.user_id = params[:user_id]
    @borrower.borrowing_address = params[:borrowing_address]

    save_status = @borrower.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/borrowers/#{@borrower.id}/edit", "/update_borrower"
        redirect_to("/borrowers/#{@borrower.id}", :notice => "Borrower updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Borrower updated successfully.")
      end
    else
      render("borrowers/edit.html.erb")
    end
  end

  def destroy
    @borrower = Borrower.find(params[:id])

    @borrower.destroy

    if URI(request.referer).path == "/borrowers/#{@borrower.id}"
      redirect_to("/", :notice => "Borrower deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Borrower deleted.")
    end
  end
end
