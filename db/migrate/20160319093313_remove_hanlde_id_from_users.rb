class RemoveHanldeIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :handle_id, :integer
  end
end
