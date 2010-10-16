class AddEventIdToProposals < ActiveRecord::Migration
  def self.up
    add_column :proposals, :event_id, :integer
  end

  def self.down
    remove_column :proposals, :event_id
  end
end
