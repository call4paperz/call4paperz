class AddMissingDeviseField < ActiveRecord::Migration[5.1]
  User = Class.new(ActiveRecord::Base)

  def change
    unless User.column_names.include? 'reset_password_sent_at'
      add_column :users, :reset_password_sent_at, :datetime
    end
  end
end
