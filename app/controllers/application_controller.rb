class ApplicationController < ActionController::Base
  before_action :authenticate_borrower!

  protect_from_forgery with: :exception
end
