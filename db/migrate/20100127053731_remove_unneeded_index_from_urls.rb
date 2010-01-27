class RemoveUnneededIndexFromUrls < ActiveRecord::Migration
  def self.up
    remove_index :urls, :href
  end

  def self.down
    add_index :urls, :href, :unique => true
  end
end
