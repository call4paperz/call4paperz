class RemoveEmailConstraintFromUsers < ActiveRecord::Migration
  def self.up
    remove_index :users, :name => 'index_users_on_email'
  end

  def self.down
    add_index :users, :email, :unique => true, :name => 'index_users_on_email'
  end
end
