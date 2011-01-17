class Bookmark < ActiveRecord::Base
  acts_as_taggable_on :tags
  
  def public
    self.tags.include?(Tag.public_tag)
  end  
  
  def published_at
    created_at
  end

  def self.recent_public_timeline
    Bookmark.order("created_at DESC").reject do |b| 
      !b.public || b.published_at < Date.today - 100.days
    end
  end
  
  def self.all_public
    Bookmark.order("created_at DESC").reject { |b| !b.public }
  end
end