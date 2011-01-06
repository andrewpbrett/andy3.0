class Admin::BookmarksController < ApplicationController
  def new
    @bookmark = Bookmark.new
  end
  
  def create
    @bookmark = Bookmark.create(params[:bookmark])
    if @bookmark.save
      flash[:success] = "Saved!"
      redirect_to admin_path
    else
      flash[:error] = "Whoops!"
      render :action => :new
    end
  end
end