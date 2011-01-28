class Admin::ImagesController < AdminController
  def index
    @images = Image.order("created_at DESC")
  end
  
  def new
    @image = Image.new
  end
  
  def create
    @image = Image.create(params[:image])
    @image.tag_list << "public" if params["public_tag"]
    @image.tag_list << "photostream" if params["photostrem_tag"]    
    if @image.save
      if params[:update_body].present? and @image.public
        tweet(params[:update_body], nil, nil, nil)        
      end      
      flash[:notice] = "Successfully created image"
      redirect_to photos_path
    else
      flash[:notice] = "Couldn't save image"
      redirect_to :action => :new
    end
  end
end