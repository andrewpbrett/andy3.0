class WelcomeController < ApplicationController
  def index
    @all_items = Post.recent_public_timeline | Update.recent_public_timeline |
      Image.photostream | Bookmark.recent_public_timeline
    @all_items = @all_items.sort_by { |a| a.published_at }.reverse
    @page_title = "Andy Brett"
  end
end