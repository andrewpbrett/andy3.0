class Tag < ActiveRecord::Base
  def self.public_tag
    ActsAsTaggableOn::Tag.find_by_name("public")
  end
  
  def self.photostream_tag
    ActsAsTaggableOn::Tag.find_by_name("photostream")
  end 
  
  def self.page_tag
    ActsAsTaggableOn::Tag.find_by_name("page")    
  end
end