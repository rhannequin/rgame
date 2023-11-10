class AddMetalMineLevelToPlanets < ActiveRecord::Migration[7.1]
  def change
    add_column :planets, :metal_mine_level, :integer, default: 1, null: false
  end
end
