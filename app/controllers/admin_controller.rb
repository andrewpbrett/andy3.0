class AdminController < ApplicationController
  before_filter :authorize
    
  def index
  end
  
  private
  
  def model_name
    params[:controller].singularize.gsub("admin\/", "")
  end
end