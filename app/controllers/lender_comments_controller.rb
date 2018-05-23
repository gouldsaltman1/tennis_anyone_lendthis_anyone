class LenderCommentsController < ApplicationController
  before_action :current_borrower_must_be_lender_comment_borrower, :only => [:edit, :update, :destroy]

  def current_borrower_must_be_lender_comment_borrower
    lender_comment = LenderComment.find(params[:id])

    unless current_borrower == lender_comment.borrower
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = LenderComment.ransack(params[:q])
    @lender_comments = @q.result(:distinct => true).includes(:borrower, :lender).page(params[:page]).per(10)

    render("lender_comments/index.html.erb")
  end

  def show
    @lender_comment = LenderComment.find(params[:id])

    render("lender_comments/show.html.erb")
  end

  def new
    @lender_comment = LenderComment.new

    render("lender_comments/new.html.erb")
  end

  def create
    @lender_comment = LenderComment.new

    @lender_comment.lender_id = params[:lender_id]
    @lender_comment.borrower_id = params[:borrower_id]

    save_status = @lender_comment.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/lender_comments/new", "/create_lender_comment"
        redirect_to("/lender_comments")
      else
        redirect_back(:fallback_location => "/", :notice => "Lender comment created successfully.")
      end
    else
      render("lender_comments/new.html.erb")
    end
  end

  def edit
    @lender_comment = LenderComment.find(params[:id])

    render("lender_comments/edit.html.erb")
  end

  def update
    @lender_comment = LenderComment.find(params[:id])

    @lender_comment.lender_id = params[:lender_id]
    @lender_comment.borrower_id = params[:borrower_id]

    save_status = @lender_comment.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/lender_comments/#{@lender_comment.id}/edit", "/update_lender_comment"
        redirect_to("/lender_comments/#{@lender_comment.id}", :notice => "Lender comment updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Lender comment updated successfully.")
      end
    else
      render("lender_comments/edit.html.erb")
    end
  end

  def destroy
    @lender_comment = LenderComment.find(params[:id])

    @lender_comment.destroy

    if URI(request.referer).path == "/lender_comments/#{@lender_comment.id}"
      redirect_to("/", :notice => "Lender comment deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Lender comment deleted.")
    end
  end
end
