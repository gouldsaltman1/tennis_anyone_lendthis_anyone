Rails.application.routes.draw do
  # Routes for the Lender resource:
  # CREATE
  get "/lenders/new", :controller => "lenders", :action => "new"
  post "/create_lender", :controller => "lenders", :action => "create"

  # READ
  get "/lenders", :controller => "lenders", :action => "index"
  get "/lenders/:id", :controller => "lenders", :action => "show"

  # UPDATE
  get "/lenders/:id/edit", :controller => "lenders", :action => "edit"
  post "/update_lender/:id", :controller => "lenders", :action => "update"

  # DELETE
  get "/delete_lender/:id", :controller => "lenders", :action => "destroy"
  #------------------------------

  # Routes for the Loan resource:
  # CREATE
  get "/loans/new", :controller => "loans", :action => "new"
  post "/create_loan", :controller => "loans", :action => "create"

  # READ
  get "/loans", :controller => "loans", :action => "index"
  get "/loans/:id", :controller => "loans", :action => "show"

  # UPDATE
  get "/loans/:id/edit", :controller => "loans", :action => "edit"
  post "/update_loan/:id", :controller => "loans", :action => "update"

  # DELETE
  get "/delete_loan/:id", :controller => "loans", :action => "destroy"
  #------------------------------

  devise_for :borrowers
  # Routes for the Borrower resource:
  # READ
  get "/borrowers", :controller => "borrowers", :action => "index"
  get "/borrowers/:id", :controller => "borrowers", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
