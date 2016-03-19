class DropIdsTable < ActiveRecord::Migration
  def change
  	drop_table :ids
  end
end
