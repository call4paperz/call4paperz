class AddCommentsCountToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :comments_count, :integer
  end
end
