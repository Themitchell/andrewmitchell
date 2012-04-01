class CreateMediaAssets < ActiveRecord::Migration
  def change
    create_table :media_assets do |t|
      t.string  :media_id
      t.string  :type
      t.string  :hosting_location_key
      t.string  :splash_screen_file_name
      t.string  :splash_screen_content_type
      t.integer :splash_screen_file_size
      t.integer :owner_id
      t.string  :owner_type

      t.timestamps
    end
  end
end
