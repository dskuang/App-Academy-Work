class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.string :body
      t.string :title
      t.timestamps null: false
    end
  end
end
