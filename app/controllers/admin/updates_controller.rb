class Admin::UpdatesController < AdminController
  def new
    @update = Update.new
  end
  
  def create
    @update = Update.create(params[:update])
    @update.published_at = Time.now()
    if @update.save
      flash[:notice] = "Successfully saved"
      geolat = params["_send_coords_to_twitter"] == "1" ? 
        @update.geolat.to_s : ""
      geolong = params["_send_coords_to_twitter"] == "1" ? 
        @update.geolong.to_s : ""
      tweet(@update.body, geolat, geolong, @update.twitterplace_id) if 
        @update.public
    end
    
    redirect_to latest_path
  end  
  
end