class AddCachedSlugToEvents < ActiveRecord::Migration[5.1]
  def self.up
    add_column :events, :cached_slug, :string
  end

  def self.down
    remove_column :events, :cached_slug
  end
end
