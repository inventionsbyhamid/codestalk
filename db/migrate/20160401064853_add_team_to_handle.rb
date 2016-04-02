class AddTeamToHandle < ActiveRecord::Migration
  def change
    add_column :handles, :team, :boolean, default: false
  end
end
