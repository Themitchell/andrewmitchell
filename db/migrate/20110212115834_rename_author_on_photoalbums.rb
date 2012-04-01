class RenameAuthorOnPhotoalbums < ActiveRecord::Migration
  def self.up
    rename_column :photoalbums, :author, :author_id
  end

  def self.down
    rename_column :photoalbums, :author_id, :author
  end
end
