class RenameCodechefIdsToHandles < ActiveRecord::Migration
  def change
  	rename_table :codechef_ids, :handles
  end
end
