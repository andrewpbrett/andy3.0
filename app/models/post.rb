class Post < ActiveRecord::Base
  validates_presence_of :permalink
  validates_uniqueness_of :permalink
  
  def self.for_blog
    posts = Post.find(:all, :conditions => { :public => true }, 
      :order => "published_at DESC" )
    posts.reject! { |p| p.title.blank? }
  end
end