class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def index
    @page_title = "Andy Brett"
  end
end
