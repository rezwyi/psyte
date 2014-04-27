class DropSlugs < ActiveRecord::Migration
  def change
    drop_table :slugs
  end
end