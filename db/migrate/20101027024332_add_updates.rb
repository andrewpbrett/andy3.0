class AddUpdates < ActiveRecord::Migration
  def self.up
    create_table :updates do |t|
      t.timestamps
      t.datetime :published_at
      t.text :body
    end
  end

  def self.down
    drop_table :updates
  end
end
