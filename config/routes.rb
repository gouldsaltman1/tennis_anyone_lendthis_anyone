Rails.application.routes.draw do
  devise_for :borrowers
  # Routes for the Borrower resource:
  # READ
  get "/borrowers", :controller => "borrowers", :action => "index"
  get "/borrowers/:id", :controller => "borrowers", :action => "show"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
