class AddLocationToUpdates < ActiveRecord::Migration
  def self.up
    add_column :updates, :geolat, :decimal, :precision => 10, :scale => 3
    add_column :updates, :geolong, :decimal, :precision => 10, :scale => 3
    add_column :updates, :twitterplace_id, :string
  end

  def self.down
    remove_column :updates, :geolat
    remove_column :updates, :geolong
    remove_column :updates, :twitterplace_id
  end                                       
end
