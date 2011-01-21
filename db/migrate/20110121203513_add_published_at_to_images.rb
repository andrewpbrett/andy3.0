class AddPublishedAtToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :published_at, :datetime
    Image.all.each do |i|
      i.update_attribute(:published_at, i.created_at)
    end
  end

  def self.down
    remove_column :images, :published_at
  end
end
