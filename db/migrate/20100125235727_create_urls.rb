class CreateUrls < ActiveRecord::Migration
  def self.up
    create_table :urls do |t|
      t.string :href

      t.timestamps
    end
    add_index :urls, :href, :unique => true
  end

  def self.down
    drop_table :urls
  end
end
