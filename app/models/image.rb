class Image < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "700x375>", :post => "530x530>", :small => "150x150>", :tiny => "75x75>"}
  
  validates_uniqueness_of :permalink

  acts_as_taggable_on :tags

  def self.recent_photostream
    Image.where("published_at > '#{Date.today - 100.days}'").order("published_at DESC").reject do |i|
      !i.public || !i.photos
    end
  end
  
  def self.photostream
    Image.order("published_at DESC").reject do |i|
      !i.public || !i.photos
    end
  end
  
  def older_photo
    Image.order("published_at DESC").where("published_at < ?", published_at).reject { |i| !i.photos }.first
  end
  
  def newer_photo
    Image.order("published_at ASC").where("published_at > ?", published_at).reject { |i| !i.photos }.first
  end
  
  def public
    self.tags.include?(Tag.public_tag)
  end
  
  def photos
    self.tags.include?(Tag.photostream_tag)
  end    
end