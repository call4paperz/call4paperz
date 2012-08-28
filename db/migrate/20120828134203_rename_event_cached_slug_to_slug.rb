class RenameEventCachedSlugToSlug < ActiveRecord::Migration
  def up
    remove_index :events, :column => :cached_slug
    rename_column :events, :cached_slug, :slug
    add_index :events, :slug, :unique => true
  end

  def down
    remove_index :events, :column => :slug
    rename_column :events, :slug, :cached_slug
    add_index :events, :cached_slug, :unique => true
  end
end
