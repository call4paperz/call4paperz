class RenamePicturesFromUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :picture, :twitter_avatar
  end
end
