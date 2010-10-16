class AddOauthFieldsToAuthentications < ActiveRecord::Migration
  def self.up
    add_column :authentications, :provider, :string
    add_column :authentications, :uid, :string
  end

  def self.down
    remove_column :authentications, :uid
    remove_column :authentications, :provider
  end
end
