class ImagesController < ApplicationController
  def show
    @image = Image.find_by_permalink(params[:permalink])
    @newer_image = @image.newer_photo
    @older_image = @image.older_photo    
  end
  
  def index
    @image = Image.last(:conditions => { :photos => true })
    @newer_image = @image.newer_photo
    @older_image = @image.older_photo
    render :action => :show
  end
end