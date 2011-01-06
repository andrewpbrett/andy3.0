class Image < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "700x700>", :post => "530x530>", :small => "150x150>", :tiny => "75x75>"}

  validates_uniqueness_of :permalink

  acts_as_taggable_on :tags
  
  def self.photostream
    Image.order("created_at DESC").reject do |i|
      !i.public || !i.photos
    end
  end
  
  def older_photo
    Image.order("created_at DESC").limit(1).where("photos = true and created_at < ?", created_at).first
  end
  
  def newer_photo
    Image.order("created_at ASC").limit(1).where("photos = true and created_at > ?", created_at).first
  end
  
  def public
    self.tags.include?(Tag.public_tag)
  end
  
  def photos
    self.tags.include?(Tag.photostream_tag)
  end    
end