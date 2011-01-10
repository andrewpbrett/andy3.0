class AddPubbedDateToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :published_at, :datetime
  end

  def self.down
    remove_column :items, :published_at
  end
end
