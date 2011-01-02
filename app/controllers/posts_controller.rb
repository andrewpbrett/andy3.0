class PostsController < ApplicationController
  def index
    @page_title = "Andy Brett | Writing"
    @posts = Post.for_blog
  end
  
  def show
    @post = Post.find_by_permalink(params[:permalink])
    if !@post || (!@post.public && current_user != User.andy)
      render :template => "application/notfound"
      @page_title = "Andy Brett"
    else
      @post.title ||= ""
      @page_title = "Andy Brett | " + @post.title
    end
  end
end