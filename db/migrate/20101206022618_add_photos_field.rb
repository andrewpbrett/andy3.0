class AddPhotosField < ActiveRecord::Migration
  def self.up
    add_column :images, :photos, :boolean
  end

  def self.down
    remove_column :images, :photos
  end
end
