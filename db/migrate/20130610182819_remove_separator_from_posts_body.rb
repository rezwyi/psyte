class RemoveSeparatorFromPostsBody < ActiveRecord::Migration
  def up
    Post.all.each do |p|
      p.body = p.body.gsub(/<!--more-->/, '')
      p.save
    end
  end

  def down
  end
end
