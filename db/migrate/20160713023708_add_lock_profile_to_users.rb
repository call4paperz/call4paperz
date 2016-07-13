class AddLockProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lock_profile, :boolean, default: false
  end
end
