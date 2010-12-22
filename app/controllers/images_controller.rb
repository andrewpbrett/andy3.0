class ImagesController < ApplicationController
  def show
    @image = Image.find_by_permalink(params[:permalink])
    @newer_image = @image.newer_photo
    @older_image = @image.older_photo    
    @page_title = "Andy Brett | Photo: #{@image.permalink.titleize}"
  end
  
  def index
    @images = Image.all(:conditions => { :photos => true }, 
      :order => "created_at DESC")
  end
end