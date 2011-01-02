class AddPublicField < ActiveRecord::Migration
  def self.up
    add_column :images, :public, :boolean
    add_column :posts, :public, :boolean
    add_column :updates, :public, :boolean
    
    Image.all.each do |i|
      i.update_attribute(:public, true)
    end
    
    Post.all.each do |p|
      p.update_attribute(:public, true)
    end
    
    Update.all.each do |u|
      u.update_attribute(:public, true)
    end
  end

  def self.down
    remove_column :images, :public
    remove_column :posts, :public
    remove_column :updates, :public
  end
end
