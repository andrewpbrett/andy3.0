class UpdatesController < ApplicationController
  def index
    @updates = Update.find(:all, :order => "published_at DESC" )
    @page_title = "Andy Brett | Latest"
  end
  
  def show
    @update = Update.find(params[:id])
    @page_title = "Andy Brett | " + @update.body    
  end
end