class CreatePictures < ActiveRecord::Migration
  def self.up
    create_table :pictures do |t|
      t.string :title
      t.text :description
      t.integer :author_id
      t.date :published_on
      t.string :picture_file_name
      t.string :picture_content_type
      t.integer :picture_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :pictures
  end
end
