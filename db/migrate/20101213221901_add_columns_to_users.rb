class AddColumnsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :dob, :date
    add_column :users, :website_url, :string
  end

  def self.down
    remove_column :users, :website_url
    remove_column :users, :dob
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end
