class AddSourceImageUrlToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :source_image_url, :text
  end

  def self.down
    drop_column :items, :source_image_url
  end
end
