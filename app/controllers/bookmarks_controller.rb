class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all_public
    @page_title = "Andy Brett | Bookmarks"
  end
  
  def show
    @bookmark = Bookmark.find_by_permalink(params[:id]) unless @bookmark
    @page_title = "Andy Brett | Bookmarks"    
  end
end