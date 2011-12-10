class Admin::ImagesController < AdminController
  def index
    @images = Image.order("created_at DESC")
  end
  
  def new
    @image = Image.new
  end
  
  def create
    @image = Image.create(params[:image])
    @image.tag_list << "public" if params["public_tag"] == "1"
    @image.tag_list << "photostream" if params["photostream_tag"] == "1"
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
  
  def edit
    @image = Image.find(params[:id])
  end
  
  def update
    @image = Image.find(params[:id])
    @image.update_attributes(params[:image])
    @image.tag_list << "public" if params["public_tag"] == "1"
    @image.tag_list << "photostream" if params["photostream_tag"] == "1"
    @image.tag_list.delete "public" if params["public_tag"] == "0"
    @image.tag_list.delete "photostream" if params["photostream_tag"] == "0"
    flash[:notice] = @image.save ? "Successfully updated image" : "Couldn't save image"
    redirect_to :action => :edit
  end
end