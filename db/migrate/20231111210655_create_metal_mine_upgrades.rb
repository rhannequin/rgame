class CreateMetalMineUpgrades < ActiveRecord::Migration[7.1]
  def change
    create_table :metal_mine_upgrades do |t|
      t.references :planet, null: false, foreign_key: true
      t.integer :target_level, null: false
      t.datetime :ends_at, null: false
      t.boolean :finished, default: false, null: false

      t.timestamps
    end
  end
end
