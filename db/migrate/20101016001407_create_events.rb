class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.text :description
      t.date :occurs_at
      t.string :picture
      t.string :url
      t.string :twitter
      t.references :user
      t.date :starts_votes_at
      t.date :end_votes_at

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
