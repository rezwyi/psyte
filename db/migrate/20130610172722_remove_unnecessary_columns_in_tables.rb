class RemoveUnnecessaryColumnsInTables < ActiveRecord::Migration
  def up
    remove_column :posts, :preface
    remove_column :posts, :content
    remove_column :projects, :title
    remove_column :projects, :source_url
    remove_column :projects, :screenshot
  end

  def down
  end
end
