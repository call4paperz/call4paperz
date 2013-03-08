class AddIndexesToApp < ActiveRecord::Migration
  def change
    add_index :proposals, :event_id
    add_index :comments, :proposal_id
  end
end
