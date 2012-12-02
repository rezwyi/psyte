class ChangeTypeOfPublishedAtOfPosts < ActiveRecord::Migration
  def up
    change_column :posts, :published_at, :date
  end

  def down
    change_column :posts, :published_at, :datetime
  end
end
