class Post < ActiveRecord::Base
  validates_presence_of :permalink
  validates_uniqueness_of :permalink
  
  def self.for_blog
    posts = Post.find(:all, :conditions => { :status => "published" }, :order => "published_at DESC" )
    posts.reject! { |p| p.title.empty? }
  end
end