class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all_public
  end
  
  def show
    @bookmark = Bookmark.find(params[:id])
  end
end