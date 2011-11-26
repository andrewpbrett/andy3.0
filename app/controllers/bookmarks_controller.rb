class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all_public
    @page_title = "Andy Brett | Bookmarks"
  end
  
  def show
    @page_title = "Andy Brett | Bookmarks"    
  end
end