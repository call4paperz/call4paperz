class CreateProposals < ActiveRecord::Migration[5.1]
  def self.up
    create_table :proposals do |t|
      t.string :name
      t.text :description
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :proposals
  end
end
