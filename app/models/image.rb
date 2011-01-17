class Image < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "700x700>", :post => "530x530>", :small => "150x150>", :tiny => "75x75>"}

  validates_uniqueness_of :permalink

  acts_as_taggable_on :tags
  
  def self.photostream
    Image.order("created_at DESC").reject do |i|
      !i.public || !i.photos || i.published_at < Date.today - 100.days
    end
  end
  
  def published_at
    created_at
  end
  
  def older_photo
    Image.order("created_at DESC").where("created_at < ?", created_at).reject { |i| !i.photos }.first
  end
  
  def newer_photo
    Image.order("created_at ASC").where("created_at > ?", created_at).reject { |i| !i.photos }.first
  end
  
  def public
    self.tags.include?(Tag.public_tag)
  end
  
  def photos
    self.tags.include?(Tag.photostream_tag)
  end    
end