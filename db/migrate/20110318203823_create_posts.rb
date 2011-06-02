class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.belongs_to :user
      t.string :title
      t.text :preface
      t.text :content
      t.text :markdown
      t.datetime :published_at

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
