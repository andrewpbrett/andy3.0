class Admin::ImagesController < ApplicationController
  before_filter :authorize
  
  def new
    @image = Image.new
  end
  
  def create
    @image = Image.create(params[:image])
    if @image.save
      flash[:notice] = "Successfully created image"
      redirect_to photos_path
    else
      flash[:notice] = "Couldn't save image"
      redirect_to :action => :new
    end
  end
end