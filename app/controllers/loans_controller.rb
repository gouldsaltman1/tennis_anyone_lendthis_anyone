class LoansController < ApplicationController
  before_action :current_borrower_must_be_loan_borrow, :only => [:edit, :update, :destroy]

  def current_borrower_must_be_loan_borrow
    loan = Loan.find(params[:id])

    unless current_borrower == loan.borrow
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @loans = Loan.all

    render("loans/index.html.erb")
  end

  def show
    @loan = Loan.find(params[:id])

    render("loans/show.html.erb")
  end

  def new
    @loan = Loan.new

    render("loans/new.html.erb")
  end

  def create
    @loan = Loan.new

    @loan.borrow_id = params[:borrow_id]
    @loan.lender_id = params[:lender_id]
    @loan.borrower_lender_equipment = params[:borrower_lender_equipment]
    @loan.equipment_id = params[:equipment_id]

    save_status = @loan.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/loans/new", "/create_loan"
        redirect_to("/loans")
      else
        redirect_back(:fallback_location => "/", :notice => "Loan created successfully.")
      end
    else
      render("loans/new.html.erb")
    end
  end

  def edit
    @loan = Loan.find(params[:id])

    render("loans/edit.html.erb")
  end

  def update
    @loan = Loan.find(params[:id])
    @loan.lender_id = params[:lender_id]
    @loan.borrower_lender_equipment = params[:borrower_lender_equipment]
    @loan.equipment_id = params[:equipment_id]

    save_status = @loan.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/loans/#{@loan.id}/edit", "/update_loan"
        redirect_to("/loans/#{@loan.id}", :notice => "Loan updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Loan updated successfully.")
      end
    else
      render("loans/edit.html.erb")
    end
  end

  def destroy
    @loan = Loan.find(params[:id])

    @loan.destroy

    if URI(request.referer).path == "/loans/#{@loan.id}"
      redirect_to("/", :notice => "Loan deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Loan deleted.")
    end
  end
end
