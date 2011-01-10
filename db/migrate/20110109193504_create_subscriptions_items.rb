class CreateSubscriptionsItems < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.string    :name
      t.text      :url
      t.timestamps
    end
    
    create_table :items do |t|
      t.integer   :subscription_id
      t.string    :external_id
      t.string    :title
      t.text      :text
      t.text      :url
      t.string    :author
      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
    drop_table :items
  end
end
