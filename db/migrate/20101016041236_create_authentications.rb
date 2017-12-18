class CreateAuthentications < ActiveRecord::Migration[5.1]
  def self.up
    create_table :authentications do |t|
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :authentications
  end
end
