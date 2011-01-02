class ImagesController < ApplicationController
  def show
    @image = Image.find_by_permalink(params[:permalink])
    if !@image || (!@image.public && current_user != User.andy)
      render :template => "application/notfound"
      @page_title = "Andy Brett"
    else
      @newer_image = @image.newer_photo
      @older_image = @image.older_photo    
      @page_title = "Andy Brett | Photo: #{@image.permalink.titleize}"
    end
  end
  
  def index
    @images = Image.all(:conditions => { :photos => true, :public => true }, 
      :order => "created_at DESC")
  end
end