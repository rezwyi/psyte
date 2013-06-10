class RemoveUnnecessaryTables < ActiveRecord::Migration
  def change
    drop_table :tags
    drop_table :taggings
    drop_table :snippets
  end
end
