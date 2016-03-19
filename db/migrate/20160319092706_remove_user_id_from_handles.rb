class RemoveUserIdFromHandles < ActiveRecord::Migration
  def change
    remove_column :handles, :user_id, :integer
  end
end
