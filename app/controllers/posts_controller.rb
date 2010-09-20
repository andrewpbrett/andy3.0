class PostsController < ApplicationController
  def index
    @posts = Post.all_published
  end
  
  def show
    @post = Post.find_by_permalink(params[:permalink])
    
    if !@post
      render :template => "application/notfound"
    end
  end
end