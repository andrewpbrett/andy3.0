class Admin::UpdatesController < ApplicationController
  before_filter :authenticate  

  def new
    @update = Update.new
  end
  
  def create
    @update = Update.create(params[:update])
    @update.published_at = Time.now()
    if @update.save
      flash[:notice] = "Successfully saved"
      tweet(@update.body)
    end
    
    redirect_to latest_path
  end  
  
end