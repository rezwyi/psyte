class AddScreenshotToProjects < ActiveRecord::Migration
  def self.up
    remove_column :projects, :image_url
    add_column :projects, :screenshot, :string
  end

  def self.down
    add_column :projects, :image_url, :string
    remove_column :projects, :screenshot
  end
end
