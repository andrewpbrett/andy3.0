class ImagesController < ApplicationController
  def show
    @image = Image.find_by_permalink(params[:permalink])
    if !@image || (!@image.public && current_user != User.andy)
      render :template => "application/notfound"
      @page_title = "Andy Brett"
    else
      @page_title = "Andy Brett | Photo: #{@image.permalink.titleize}"
    end
  end
  
  def index
    @images = Image.photostream
    @page_title = "Andy Brett | Photos"
  end
end