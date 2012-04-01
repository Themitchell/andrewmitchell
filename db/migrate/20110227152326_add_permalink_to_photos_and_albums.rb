class AddPermalinkToPhotosAndAlbums < ActiveRecord::Migration
  def self.up
    add_column :photoalbums, :permalink, :string
    add_column :pictures, :permalink, :string
  end

  def self.down
    remove_column :pictures, :permalink
    remove_column :photoalbums, :permalink
  end
end
