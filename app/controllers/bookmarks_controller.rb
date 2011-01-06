class BookmarksController < ApplicationController
  def index
    @bookmarks = Bookmark.all_public
  end
end