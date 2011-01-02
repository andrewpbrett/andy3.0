class Admin::UpdatesController < ApplicationController
  before_filter :authorize  

  def new
    @update = Update.new
  end
  
  def create
    @update = Update.create(params[:update])
    @update.published_at = Time.now()
    if @update.save
      flash[:notice] = "Successfully saved"
      geolat = params["_send_coords_to_twitter"] == "1" ? 
        @update.geolat.to_s("8F") : ""
      geolong = params["_send_coords_to_twitter"] == "1" ? 
        @update.geolong.to_s("8F") : ""
      tweet(@update.body, geolat, geolong, @update.twitterplace_id) if 
        @update.public
    end
    
    redirect_to latest_path
  end  
  
end