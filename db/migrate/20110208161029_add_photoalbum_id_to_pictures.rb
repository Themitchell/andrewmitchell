class AddPhotoalbumIdToPictures < ActiveRecord::Migration
  def self.up
    add_column :pictures, :photoalbum_id, :integer
  end

  def self.down
    remove_column :pictures, :photoalbum_id
  end
end
