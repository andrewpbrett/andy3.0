class PostsController < ApplicationController
  def index
    @page_title = "Andy Brett | Writing"
    @posts = Post.public_timeline
  end
  
  def show
    @post = Post.find_by_permalink(params[:permalink])
    if !@post.public && current_user != User.andy
      render :template => "application/notfound"
      @page_title = "Andy Brett"
    else
      @post.title ||= ""
      @page_title = "Andy Brett" 
      @page_title += (" | " + @post.title) if @post.title.present?
    end
  end
end