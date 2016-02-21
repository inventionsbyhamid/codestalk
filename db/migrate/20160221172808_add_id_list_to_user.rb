class AddIdListToUser < ActiveRecord::Migration
  def change
    add_column :users, :id_list, :text
  end
end
