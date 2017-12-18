class CreateVotes < ActiveRecord::Migration[5.1]
  def self.up
    create_table :votes do |t|
      t.integer :direction
      t.references :proposal
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
