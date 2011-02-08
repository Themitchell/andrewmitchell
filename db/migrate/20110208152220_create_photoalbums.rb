class CreatePhotoalbums < ActiveRecord::Migration
  def self.up
    create_table :photoalbums do |t|
      t.integer   :author
      t.string    :name
      t.text      :description
      t.timestamp :published_on

      t.timestamps
    end
  end

  def self.down
    drop_table :albums
  end
end
