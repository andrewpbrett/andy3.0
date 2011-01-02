class Admin::ImagesController < ApplicationController
  before_filter :authorize
  
  def new
    @image = Image.new
  end
  
  def create
    @image = Image.create(params[:image])
    flash[:notice] = "Successfully created image" if @image.save
    redirect_to :action => :new
  end
end