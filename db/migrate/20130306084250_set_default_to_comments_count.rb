class SetDefaultToCommentsCount < ActiveRecord::Migration[5.1]
  def up
    change_column_default :proposals, :comments_count, 0
  end

  def down
    change_column_default :proposals, :comments_count, nil
  end
end
