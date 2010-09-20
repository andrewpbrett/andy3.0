class Admin::PostsController < ApplicationController
  before_filter :authenticate  
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.create(params[:post])
    
    @post.published_at = Time.now if @post.status = "published"
    
    if @post.save
      flash[:notice] = "Successfully saved"
    end
    
    redirect_to :action => :edit, :id => @post.id
  end

  def edit
    @post = Post.find(params[:id])
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
      user == "andy" && pass == pwd["andy"]
    end
  end  
end