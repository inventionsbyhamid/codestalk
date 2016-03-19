class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :handles, :users do |t|
       t.index [:handle_id, :user_id]
       t.index [:user_id, :handle_id]
    end
  end
end
