class ChangeBookmarksColumn < ActiveRecord::Migration
  def self.up
    change_column :bookmarks, :note, :text
  end

  def self.down
    change_column :bookmarks, :note, :string
  end
end
