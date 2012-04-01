class ChangeEmailOnUsers < ActiveRecord::Migration
  def change
    remove_column :users, :email
    add_column    :users, :email, :string
    add_index     :users, :email, :name => "index_users_on_email"
  end
end