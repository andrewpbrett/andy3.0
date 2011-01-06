class Update < ActiveRecord::Base
  validates_presence_of :published_at
  validates_uniqueness_of :published_at
  validates_presence_of :body

  acts_as_taggable_on :tags
  
  def public
    self.tags.include?(Tag.public_tag)
  end    
end