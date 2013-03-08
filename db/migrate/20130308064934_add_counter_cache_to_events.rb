class AddCounterCacheToEvents < ActiveRecord::Migration
  def change
    add_column :events, :proposals_count, :integer
  end
end
