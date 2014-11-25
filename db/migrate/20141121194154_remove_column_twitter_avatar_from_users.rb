class RemoveColumnTwitterAvatarFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :twitter_avatar
  end

  def down
    add_column :users, :twitter_avatar, :string
  end
end
