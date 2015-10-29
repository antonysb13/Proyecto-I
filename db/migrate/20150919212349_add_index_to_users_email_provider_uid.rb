class AddIndexToUsersEmailProviderUid < ActiveRecord::Migration
  def change
  	add_index "users", ["email", "provider", "uid"], :name => "index_users", :unique => true
  end
end