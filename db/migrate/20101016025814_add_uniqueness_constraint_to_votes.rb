class AddUniquenessConstraintToVotes < ActiveRecord::Migration
  def self.up
    add_index :votes, [:proposal_id, :user_id], :unique => true
  end

  def self.down
    remove_index :votes, :column => [:proposal_id, :user_id]
  end
end
