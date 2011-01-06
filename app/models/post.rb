class Post < ActiveRecord::Base
  validates_presence_of :permalink
  validates_uniqueness_of :permalink

  acts_as_taggable_on :tags
  
  def self.public_timeline
    posts = Post.find(:all, :order => "published_at DESC" )
    posts.reject! do |p| 
      p.tags.include?(Tag.page_tag) || !p.tags.include?(Tag.public_tag)
    end
  end
  
  def public
    self.tags.include?(Tag.public_tag)
  end  
end