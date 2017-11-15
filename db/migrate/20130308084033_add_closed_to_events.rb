class AddClosedToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :closed_at, :datetime
  end
end
