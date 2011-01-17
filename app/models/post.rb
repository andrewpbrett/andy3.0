class Post < ActiveRecord::Base
  validates_presence_of :permalink
  validates_uniqueness_of :permalink

  acts_as_taggable_on :tags

  def self.recent_public_timeline
    posts = Post.where("published_at > '#{Date.today - 100.days}'").order("published_at DESC")
    posts.reject do |p|
      p.tags.include?(Tag.page_tag) || !p.tags.include?(Tag.public_tag)
    end
  end
  
  def self.public_timeline
    posts = Post.find(:all, :order => "published_at DESC" )
    posts.reject do |p| 
      p.tags.include?(Tag.page_tag) || !p.tags.include?(Tag.public_tag)
    end
  end
  
  def public
    self.tags.include?(Tag.public_tag)
  end
  
  def smart_excerpt
    clipped_body = body[0..500]
    clipped_body += "..." if body.length > 500
    excerpt.present? ? excerpt : clipped_body
  end
end