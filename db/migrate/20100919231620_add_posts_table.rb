class AddPostsTable < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.timestamps
      t.string :title
      t.text :body
      t.text :excerpt
      t.string :status
      t.string :permalink
    end
  end

  def self.down
    drop_table :posts
  end
end
