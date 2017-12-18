class AddCommentsCountToProposals < ActiveRecord::Migration[5.1]
  def change
    add_column :proposals, :comments_count, :integer
  end
end
