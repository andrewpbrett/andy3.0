class Bookmark < ActiveRecord::Base
  acts_as_taggable_on :tags
  
  def public
    self.tags.include?(Tag.public_tag)
  end  
  
  def self.all_public
    Bookmark.order("created_at DESC").reject { |b| !b.public }
  end
end