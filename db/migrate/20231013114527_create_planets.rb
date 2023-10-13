class CreatePlanets < ActiveRecord::Migration[7.1]
  def change
    create_table :planets do |t|
      t.references :user, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
