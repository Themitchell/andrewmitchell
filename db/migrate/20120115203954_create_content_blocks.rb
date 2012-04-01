class CreateContentBlocks < ActiveRecord::Migration
  def change
    create_table :content_blocks do |t|
      t.string :name
      t.text :body

      t.timestamps
    end
  end
end
