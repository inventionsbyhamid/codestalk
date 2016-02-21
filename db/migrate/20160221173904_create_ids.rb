class CreateIds < ActiveRecord::Migration
  def change
    create_table :ids do |t|
      t.string :user_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
