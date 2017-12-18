class AddCounterCacheToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :proposals_count, :integer
  end
end
