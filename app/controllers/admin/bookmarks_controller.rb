class Admin::BookmarksController < AdminController
  def index
    @bookmarks = Bookmark.order("created_at DESC")
  end
  
  def new
    @bookmark = Bookmark.new(:title => params[:title], :url => params[:url])
  end
  
  def create
    @bookmark = Bookmark.create(params[:bookmark])
    if @bookmark.save
      if params[:update_body].present? and @bookmark.public
        tweet(params[:update_body], nil, nil, nil)        
      end
      flash[:notice] = "Saved!"
      redirect_to admin_path
    else
      flash[:error] = "Whoops!"
      render :action => :new
    end
  end
  
  def edit
  end
  
  def update
    @bookmark.update_attributes(params[:bookmark])
    flash[:notice] = @bookmark.errors.present? ? "Whoops!" : "Saved!"
    redirect_to :action => :edit
  end
end