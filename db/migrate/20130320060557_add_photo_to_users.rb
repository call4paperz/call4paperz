class AddPhotoToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :photo, :string
  end
end
