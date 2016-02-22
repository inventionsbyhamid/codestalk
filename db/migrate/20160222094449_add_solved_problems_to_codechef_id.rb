class AddSolvedProblemsToCodechefId < ActiveRecord::Migration
  def change
    add_column :codechef_ids, :solved_problems, :text
  end
end
