class AddIndexesToApp < ActiveRecord::Migration[5.1]
  def change
    add_index :proposals, :event_id
  end
end
