class RestoreIndexToUserEmail < ActiveRecord::Migration
  def change
  	remove_index "users", :name => "index_users"
	add_index :users, :email, unique: true
  end
end
