class DropVestigialColumns < ActiveRecord::Migration
  def self.up
    remove_column :posts, :public
    remove_column :images, :public
    remove_column :images, :photos
    remove_column :updates, :public
  end

  def self.down
    add_column :posts, :public, :boolean
    add_column :images, :public, :boolean
    add_column :images, :photos, :boolean
    add_column :updates, :public, :boolean
  end
end
