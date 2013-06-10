class RenameMarkdownToBodyInPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :markdown, :body
  end
end
