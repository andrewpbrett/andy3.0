class Update < ActiveRecord::Base
  validates_presence_of :published_at
  validates_uniqueness_of :published_at
  validates_presence_of :body
  
end