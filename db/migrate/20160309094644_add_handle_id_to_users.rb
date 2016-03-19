class AddHandleIdToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :handle_id, :integer
    add_index  :users, :handle_id
  end
end
