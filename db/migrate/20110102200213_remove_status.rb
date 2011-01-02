class RemoveStatus < ActiveRecord::Migration
  def self.up
    remove_column :posts, :status
  end

  def self.down
    add_column :posts, :status, :string
  end
end
