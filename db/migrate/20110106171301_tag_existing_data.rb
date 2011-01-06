class TagExistingData < ActiveRecord::Migration

  # Done previously in rails console: 
  # >> Tag.create(:name => "public")
  # >> Tag.create(:name => "daily_email")
  # >> Tag.create(:name => "photostream") 

  def self.up
    Post.all.each do |p|
      p.tag_list << "public" if p.public
      p.tag_list << "daily-email" if p.permalink.match /^my-life-/
      p.save
    end
    
    Image.all.each do |i|
      i.tag_list << "public" if i.public
      i.tag_list << "photostream" if i.photos
      i.save
    end
    
    Update.all.each do |u|
      u.tag_list << "public" if u.public
      u.save
    end
  end

  def self.down
    Post.all.each do |p|
      p.tag_list = ""
      p.save
    end
    
    Image.all.each do |i|
      i.tag_list = ""
      i.save
    end
    
    Update.all.each do |u|
      u.tag_list = ""
      u.save
    end
  end
end
