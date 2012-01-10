class AddPermalinkToBookmarks < ActiveRecord::Migration
  def change
    add_column :bookmarks, :permalink, :string
  end
end
