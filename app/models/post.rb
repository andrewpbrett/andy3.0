class Post < ActiveRecord::Base
  validates_presence_of :permalink
  
  def self.all_published
    Post.where({ :status => "published" })
  end
end