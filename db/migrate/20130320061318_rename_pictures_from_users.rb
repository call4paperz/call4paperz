class RenamePicturesFromUsers < ActiveRecord::Migration
  def change
    rename_column :users, :picture, :twitter_avatar
  end
end
