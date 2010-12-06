class AddImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string      :permalink
      # paperclip fields
      t.string      :image_file_name
      t.string      :image_content_type
      t.integer     :image_file_size
      t.datetime    :image_updated_at
      # end paperclip fields
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
