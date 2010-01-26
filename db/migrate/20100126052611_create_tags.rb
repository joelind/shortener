class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.references :url, :foreign_key => true
      t.string :text

      t.timestamps
    end
    add_index :tags, [:url_id, :text]
    add_index :tags, :text
  end

  def self.down
    drop_table :tags
  end
end
