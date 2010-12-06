class Image < ActiveRecord::Base
  has_attached_file :image

  validates_uniqueness_of :permalink
  
  def older_photo
    Image.order("created_at DESC").limit(1).where("photos = true and created_at < ?", created_at).first
  end
  
  def newer_photo
    Image.order("created_at ASC").limit(1).where("photos = true and created_at > ?", created_at).first
  end
end