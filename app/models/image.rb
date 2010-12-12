class Image < ActiveRecord::Base
  has_attached_file :image, :styles => { :medium => "700x700>", :post => "600x600>", :small => "150x150>", :tiny => "75x75>"}

  validates_uniqueness_of :permalink
  
  def older_photo
    Image.order("created_at DESC").limit(1).where("photos = true and created_at < ?", created_at).first
  end
  
  def newer_photo
    Image.order("created_at ASC").limit(1).where("photos = true and created_at > ?", created_at).first
  end
end