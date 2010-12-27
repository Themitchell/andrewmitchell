class ChangePublishedOnToDatetime < ActiveRecord::Migration
  def self.up
    change_column :posts, :published_on, :datetime
    change_column :pictures, :published_on, :datetime
  end
  
  def self.down
    change_column :pictures, :published_on, :date
    change_column :posts, :published_on, :date
  end
end
