class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.string :production_url
      t.string :source_url
      t.text :description, null: false

      t.timestamps
    end

  end

  def self.down
    drop_table :projects
  end
end
