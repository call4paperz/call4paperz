class RemoveEmailConstraintFromUsers < ActiveRecord::Migration[5.1]
  def self.up
    remove_index :users, :name => 'index_users_on_email'
  end

  def self.down
    add_index :users, :email, :unique => true, :name => 'index_users_on_email'
  end
end
