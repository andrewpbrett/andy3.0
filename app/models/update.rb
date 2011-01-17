class Update < ActiveRecord::Base
  validates_presence_of :published_at
  validates_uniqueness_of :published_at
  validates_presence_of :body

  acts_as_taggable_on :tags
  
  def self.recent_public_timeline
    updates = Update.where("published_at > '#{Date.today - 100.days}'").order("published_at DESC" )
    updates.reject { |u| !u.public }
  end
  
  def public
    self.tags.include?(Tag.public_tag)
  end    
end