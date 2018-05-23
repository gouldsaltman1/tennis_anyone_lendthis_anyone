Rails.application.routes.draw do
  root :to => "loans#index"
  # Routes for the Lender_comment resource:
  # CREATE
  get "/lender_comments/new", :controller => "lender_comments", :action => "new"
  post "/create_lender_comment", :controller => "lender_comments", :action => "create"

  # READ
  get "/lender_comments", :controller => "lender_comments", :action => "index"
  get "/lender_comments/:id", :controller => "lender_comments", :action => "show"

  # UPDATE
  get "/lender_comments/:id/edit", :controller => "lender_comments", :action => "edit"
  post "/update_lender_comment/:id", :controller => "lender_comments", :action => "update"

  # DELETE
  get "/delete_lender_comment/:id", :controller => "lender_comments", :action => "destroy"
  #------------------------------

  # Routes for the Equipment_comment resource:
  # CREATE
  get "/equipment_comments/new", :controller => "equipment_comments", :action => "new"
  post "/create_equipment_comment", :controller => "equipment_comments", :action => "create"

  # READ
  get "/equipment_comments", :controller => "equipment_comments", :action => "index"
  get "/equipment_comments/:id", :controller => "equipment_comments", :action => "show"

  # UPDATE
  get "/equipment_comments/:id/edit", :controller => "equipment_comments", :action => "edit"
  post "/update_equipment_comment/:id", :controller => "equipment_comments", :action => "update"

  # DELETE
  get "/delete_equipment_comment/:id", :controller => "equipment_comments", :action => "destroy"
  #------------------------------

  # Routes for the Equipment resource:
  # CREATE
  get "/equipment/new", :controller => "equipment", :action => "new"
  post "/create_equipment", :controller => "equipment", :action => "create"

  # READ
  get "/equipment", :controller => "equipment", :action => "index"
  get "/equipment/:id", :controller => "equipment", :action => "show"

  # UPDATE
  get "/equipment/:id/edit", :controller => "equipment", :action => "edit"
  post "/update_equipment/:id", :controller => "equipment", :action => "update"

  # DELETE
  get "/delete_equipment/:id", :controller => "equipment", :action => "destroy"
  #------------------------------

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
