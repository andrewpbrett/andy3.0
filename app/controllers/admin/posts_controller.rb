class Admin::PostsController < ApplicationController
  before_filter :authenticate  
  
  def index
    @posts = Post.all(:order => "published_at DESC")
  end  
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.create(params[:post])
    
    if @post.save
      flash[:notice] = "Successfully saved"
    end
    
    redirect_to :action => :edit, :id => @post.id
  end

  def edit
    @post = Post.find(params[:id]) if params[:id]
    @post ||= Post.find_by_permalink(params[:permalink])
  end
  
  def update
    @post = Post.find(params[:id])

    if @post.update_attributes(params[:post])
      flash[:notice] = "Successfully updated"
    end    

    redirect_to :action => :edit    
  end
  
  private

  def authenticate
    pwd = YAML.load_file("config/pwd.yml")
    authenticate_or_request_with_http_basic do |user, pass|
      auth = (user == "andy" && pass == pwd["andy"])
      @authenticated = true
      auth
    end
  end  
end