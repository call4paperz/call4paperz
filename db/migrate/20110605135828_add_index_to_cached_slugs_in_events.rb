class AddIndexToCachedSlugsInEvents < ActiveRecord::Migration
  def self.up
    add_index :events, :cached_slug, :unique => true
  end

  def self.down
    remove_index :events, :column => :cached_slug
  end
end
