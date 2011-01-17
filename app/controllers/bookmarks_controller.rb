class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all_public
    @page_title = "Andy Brett | Readings"
  end
  
  def show
    @bookmark = Bookmark.find(params[:id])
    @page_title = "Andy Brett | Readings"    
  end
end