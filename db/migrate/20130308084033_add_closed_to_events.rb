class AddClosedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :closed_at, :datetime
  end
end
