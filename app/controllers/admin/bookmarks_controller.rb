class Admin::BookmarksController < AdminController
  def index
    @bookmarks = Bookmark.order("created_at DESC")
  end
  
  def new
    @bookmark = Bookmark.new
  end
  
  def create
    @bookmark = Bookmark.create(params[:bookmark])
    if @bookmark.save
      flash[:notice] = "Saved!"
      redirect_to admin_path
    else
      flash[:error] = "Whoops!"
      render :action => :new
    end
  end
end